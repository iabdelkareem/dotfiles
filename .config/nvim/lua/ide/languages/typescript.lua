local M = {}

function M.get_lsp_configs()
	return {
		eslint = {},
	}
end

function M.get_plugin_specs()
	return {
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			config = function()
				require("typescript-tools").setup({
					expose_as_code_action = "all",
				})
			end,
		},
	}
end

return M
