local M = {}

local function init()
	vim.g.splitkeep = "screen"
	vim.keymap.set("n", "<Del>", "<C-W>h", { desc = "Left Window" })
	vim.keymap.set("n", "<PageDown>", "<C-W>l", { desc = "Right Window" })
	vim.keymap.set("n", "<Home>", "<C-W>k", { desc = "Up Window" })
	vim.keymap.set("n", "<End>", "<C-W>j", { desc = "Down Window" })
end

function M.get_plugin_specs()
	init()
	return {
		{
			"beauwilliams/focus.nvim",
			config = function()
				require("focus").setup({
					ui = {
						hybridnumber = true,
						signcolumn = false,
					},
				})

				local focusmap = function(direction, desc)
					vim.keymap.set("n", "<leader>" .. direction, function()
						require("focus").split_command(direction)
					end, { noremap = true, desc = desc })
				end

				focusmap("h", "Split Left")
				focusmap("j", "Split Down")
				focusmap("k", "Split Up")
				focusmap("l", "Split Right")

				local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

				local ignore_filetypes = { "NvimTree", "DiffviewFiles", "octo_panel", "Trouble" }

				vim.keymap.set("n", "<leader>=", "<CMD>FocusEqualise<CR>", { silent = true, desc = "Focus Equalise" })

				vim.api.nvim_create_autocmd("FileType", {
					group = augroup,
					callback = function(_)
						if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
							vim.b.focus_disable = true
						end
					end,
					desc = "Disable focus autoresize for FileType",
				})
			end,
		},
		{
			"karb94/neoscroll.nvim",
			config = function()
				require("neoscroll").setup({
					hide_cursor = true,
					stop_eof = true,
					respect_scrolloff = true,
					cursor_scrolls_alone = false,
				})
			end,
		},
	}
end

return M
