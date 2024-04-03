local M = {}

local function register_keymaps()
	local bufferline = require("bufferline")
	-- Next
	vim.keymap.set("n", "L", function() bufferline.cycle(1) end, { noremap = true, desc = "Next Buffer" })

	vim.keymap.set("n", ">b", function() bufferline.move(1) end, { noremap = true, desc = "Shift Buffer Right" })

	-- Prev
	vim.keymap.set("n", "H", function() bufferline.cycle(-1) end, { noremap = true, desc = "Prev Buffer" })
	vim.keymap.set("n", "<b", function() bufferline.move(-1) end, { noremap = true, desc = "Shift Buffer Left" })

	-- Close
	vim.keymap.set("n", "]q", function() bufferline.close_in_direction("right") end, { noremap = true, desc = "Close Right Buffers" })
	vim.keymap.set("n", "[q", function() bufferline.close_in_direction("left") end, { noremap = true, desc = "Close Left Buffers" })

	vim.keymap.set("n", "<leader>q", function()
		local current_buf = vim.api.nvim_get_current_buf()
		bufferline.cycle(-1)
		require("bufdelete").bufdelete(current_buf, false)
	end, { noremap = true, desc = "Close Buffer" })

	vim.keymap.set("n", "<leader>Q", bufferline.close_others, { noremap = true, silent = true, desc = "Close All" })
end

local function config()
	register_keymaps()

	local close_buffer_command = function() require("bufdelete").bufdelete(0, false) end

	require("bufferline").setup({
		options = {
			numbers = "none",
			close_command = close_buffer_command,
			separator_style = "slant" or "padded_slant",
			diagnostics = "nvim_lsp",
			show_tab_indicators = true,
			show_buffer_close_icons = false,
			show_close_icon = false,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "left",
					separator = true,
				},
			},
			sort_by = "insert_after_current",
			custom_filter = function(current_buffer, buf_nums)
				if vim.api.nvim_get_current_buf() == current_buffer then
					return true
				end

				local cwd = vim.loop.cwd()
				local current_buf_path = vim.api.nvim_buf_get_name(current_buffer)

				local files = {}
				for _, buf in ipairs(require("harpoon"):list().items) do
					---@type string
					local harpoon_file_path = cwd .. "/" .. buf.value
					if harpoon_file_path == current_buf_path then
						return true
					end
				end

				return false
			end,
		},
	})
end

function M.get_plugin_specs()
	vim.opt.termguicolors = true

	return {
		{
			"famiu/bufdelete.nvim",
			cond = not require("utils").is_vscode(),
		},
		{
			"akinsho/nvim-bufferline.lua",
			dependencies = { "famiu/bufdelete.nvim", "nvim-tree/nvim-web-devicons" },
			cond = not require("utils").is_vscode(),
			version = "*",
			config = config,
		},
	}
end

return M
