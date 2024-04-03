local M = {}

local map = vim.keymap.set
local default_opts = { silent = true }
local expr_opts = { expr = true, silent = true }

vim.g.mapleader = " "
-- Visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Paste over currently selected text without yanking it
map("v", "p", "\"_dP", default_opts)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", default_opts)
map("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>", default_opts)
map("n", "<Right>", ":vertical resize -1<CR>", default_opts)
map("n", "<Up>", ":resize -1<CR>", default_opts)
map("n", "<Down>", ":resize +1<CR>", default_opts)
map("n", "<leader>w", "<cmd>update!<CR>", { noremap = true, silent = true, desc = "Save" })

function M.get_plugin_specs()
	return {
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			cond = not require("utils").is_vscode(),
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
				require("which-key").setup()
				-- vim.keymap.set("n", "<leader>?", "<cmd>WhichKey<CR>", { noremap = true, silent = true, desc = "Which-Key" })
			end,
		},
		-- TODO: Configure & Enable
		{
			"nvimtools/hydra.nvim",
			enabled = false,
			config = function()
				local hydra = require("hydra")

				hydra({
					name = "Vertical Scroll",
					mode = "n",
					body = "<C>",
					heads = {
						{ "u", "<C-u>" },
						{ "d", "<C-d>" },
						{ "e", "<C-e>" },
						{ "y", "<C-y>" },
					},
				})
			end,
		},
	}
end

return M
