local M = {}

function M.get_lsp_configs()
	return {
		marksman = {},
	}
end

function M.get_plugin_specs()
	return {
		{
			"iamcco/markdown-preview.nvim",
			build = "cd app && npm install",
			ft = "markdown",
			init = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
		},
		{
			"AckslD/nvim-FeMaco.lua",
			ft = "markdown",
			config = function()
				require("femaco").setup()
			end,
		},
		{
			"ellisonleao/glow.nvim",
			ft = "markdown",
			config = function()
				require("glow").setup({})
			end,
		},
	}
end

return M
