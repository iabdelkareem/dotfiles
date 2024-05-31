local const = require("const")
local M = {}

local function init()
	vim.g.splitkeep = "screen"
	vim.keymap.set("n", "<Del>", "<C-W>h", { desc = "Left Window" })
	vim.keymap.set("n", "<PageDown>", "<C-W>l", { desc = "Right Window" })
	vim.keymap.set("n", "<Home>", "<C-W>k", { desc = "Up Window" })
	vim.keymap.set("n", "<End>", "<C-W>j", { desc = "Down Window" })
end

local function config_focus()
	local focus = require("focus")
	focus.setup({
		ui = {
			hybridnumber = true,
			signcolumn = false,
		},
	})

	local focusmap = function(direction, desc)
		vim.keymap.set("n", "<leader>" .. direction, function() focus.split_command(direction) end, { noremap = true, desc = desc })
	end

	focusmap("h", "Split Left")
	focusmap("j", "Split Down")
	focusmap("k", "Split Up")
	focusmap("l", "Split Right")
	vim.keymap.set("n", "<leader>=", focus.focus_equalise, { silent = true, desc = "Focus Equalise" })
	vim.keymap.set("n", "<leader>+", focus.focus_max_or_equal, { silent = true, desc = "Focus Toggle Maximize" })
	vim.keymap.set("n", "<leader>-", focus.focus_toggle_buffer, { silent = true, desc = "Focus Toggle Buffer" })

	local ignore_filetypes = {
		const.special_ft.nvim_tree,
		const.special_ft.diffview_files,
		const.special_ft.octo_panel,
		const.special_ft.trouble,
		const.special_ft.toggleterm,
	}

	local ignore_buftypes = { "nofile", "prompt", "popup", "terminal" }

	local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

	vim.api.nvim_create_autocmd("WinEnter", {
		group = augroup,
		callback = function(_)
			if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
				vim.w.focus_disable = true
			else
				vim.w.focus_disable = false
			end
		end,
		desc = "Disable focus autoresize for BufType",
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = augroup,
		callback = function(_)
			if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
				vim.b.focus_disable = true
			else
				vim.b.focus_disable = false
			end
		end,
		desc = "Disable focus autoresize for FileType",
	})
end

function M.get_plugin_specs()
	init()
	return {
		{
			"nvim-focus/focus.nvim",
			cond = not require("utils").is_vscode(),
			version = "*",
			config = config_focus,
		},
		{
			"karb94/neoscroll.nvim",
			cond = not require("utils").is_vscode(),
			config = function()
				require("neoscroll").setup({
					respect_scrolloff = true,
					cursor_scrolls_alone = false,
				})
			end,
		},
		{
			"b0o/incline.nvim",
			cond = not require("utils").is_vscode(),
			config = function()
				local devicons = require("nvim-web-devicons")
				require("incline").setup({
					render = function(props)
						local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
						if filename == "" then
							filename = "[No Name]"
						end
						local ft_icon, ft_color = devicons.get_icon_color(filename)

						local function get_git_diff()
							local icons = { removed = "", changed = "", added = "" }
							local signs = vim.b[props.buf].gitsigns_status_dict
							local labels = {}
							if signs == nil then
								return labels
							end
							for name, icon in pairs(icons) do
								if tonumber(signs[name]) and signs[name] > 0 then
									table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
								end
							end
							if #labels > 0 then
								table.insert(labels, { "┊ " })
							end
							return labels
						end

						local function get_diagnostic_label()
							local icons = { error = "", warn = "" }
							local label = {}

							for severity, icon in pairs(icons) do
								local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
								if n > 0 then
									table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
								end
							end
							if #label > 0 then
								table.insert(label, { "┊ " })
							end
							return label
						end

						return {
							{ get_diagnostic_label() },
							{ get_git_diff() },
							{ (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
							{ filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
						}
					end,
				})
			end,
		},
		{
			"s1n7ax/nvim-window-picker",
			config = function()
				vim.keymap.set("n", "<C-q>", function()
					local winid = require("window-picker").pick_window({
						filter_rules = {
							include_current_win = true,
						},
					})
					vim.api.nvim_win_close(winid, false)
				end, { noremap = true, desc = "Close Window" })
			end,
		},
		{
			"nvim-zh/colorful-winsep.nvim",
			config = true,
			event = { "WinNew" },
		},
	}
end

return M
