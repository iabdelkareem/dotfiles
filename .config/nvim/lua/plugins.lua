local utils = require("utils")

local function ensure_lazy_nvim_installed()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

ensure_lazy_nvim_installed()

local plugins = {}
utils.extend_plugin_specs(plugins, "theme")
utils.extend_plugin_specs(plugins, "core")
utils.extend_plugin_specs(plugins, "coding")
utils.extend_plugin_specs(plugins, "extensions")
vim.list_extend(plugins, {
	{
		"iabdelkareem/aws.nvim",
		dependencies = {
			"nvim-neo-tree/neo-tree.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			config = function()
				require("aws").setup({})
				vim.keymap.set("n", "<leader>aa", require("aws.tree").toggle_tree, { desc = "Toggle AWS Explorer" })
			end,
		},
		dev = true,
	},
	{
		"Pocco81/true-zen.nvim",
		config = function()
			local truezen = require("true-zen")
			truezen.setup({})

			local keymap = vim.keymap

			keymap.set("n", "<leader>vn", function()
				local first = 0
				local last = vim.api.nvim_buf_line_count(0)
				truezen.narrow(first, last)
			end, { noremap = true, desc = "Zen Narrow" })
			keymap.set("v", "<leader>vn", function()
				local first = vim.fn.line("v")
				local last = vim.fn.line(".")
				truezen.narrow(first, last)
			end, { noremap = true, desc = "Zen Narrow" })
			keymap.set("n", "<leader>vf", truezen.focus, { noremap = true, desc = "Zen Focus" })
			keymap.set("n", "<leader>vm", truezen.minimalist, { noremap = true, desc = "Zen Minimalist" })
			keymap.set("n", "<leader>va", truezen.ataraxis, { noremap = true, desc = "Zen Ataraxis" })
		end,
	},
	{
		"folke/zen-mode.nvim",
	},
})

require("lazy").setup(plugins, { dev = { path = "~/personal/repos" } })

-- plenary
