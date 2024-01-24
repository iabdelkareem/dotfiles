local M = {}

local map = vim.keymap.set
local default_opts = { silent = true }
local expr_opts = { expr = true, silent = true }

vim.g.mapleader = " "
-- Switch to normal mode
-- map("i", "jk", "<ESC>", default_opts)

-- Center search results
map("n", "n", "nzz", default_opts)
map("n", "N", "Nzz", default_opts)

-- Visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
map("v", "<", "<gv", default_opts)
map("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
map("v", "p", "\"_dP", default_opts)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", default_opts)
map("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>", default_opts)
map("n", "<Right>", ":vertical resize -1<CR>", default_opts)
map("n", "<Up>", ":resize -1<CR>", default_opts)
map("n", "<Down>", ":resize +1<CR>", default_opts)
map("n", "<leader>w", "<cmd>update!<CR>", { noremap = true, silent = true, desc = "Save" })
map("n", "<leader>?", "<cmd>WhichKey<CR>", { noremap = true, silent = true, desc = "Which-Key" })

-- Remap record macro

-- vim.cmd("noremap <leader>q q")
-- map("n", "<leader>q", "q", { silent = true, desc = "Record" })

function M.get_plugin_specs()
	return {
		{
			"folke/which-key.nvim",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
				require("which-key").setup()
			end,
		},
		{
			"anuvyklack/hydra.nvim",
			config = function()
				-- local hydra = require("hydra")
				--
				-- hydra({
				--   name = "Vertical Scroll",
				--   mode = "n",
				--   body = "<C>",
				--   heads = {
				--     { "u", "<C-u>" },
				--     { "d", "<C-d>" },
				--     { "e", "<C-e>" },
				--     { "y", "<C-y>" },
				--   },
				-- })
			end,
		},
	}
end

return M
