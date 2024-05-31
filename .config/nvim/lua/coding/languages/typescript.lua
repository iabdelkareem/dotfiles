local M = {}

function M.get_lsp_configs()
	return {
		eslint = {
			settings = {
				packageManager = "npm",
				format = false,
			},
		},
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
					complete_function_calls = true,
					tsserver_file_preferences = {
						includeCompletionsForModuleExports = true,
						includeCompletionsForImportStatements = true,
					},
				})
			end,
		},
	}
end

return M
