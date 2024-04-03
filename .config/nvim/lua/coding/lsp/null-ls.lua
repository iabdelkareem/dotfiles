local M = {}

function M.get_plugin_specs()
	return {
		{
			"nvimtools/none-ls.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"williamboman/mason.nvim",
			},
			config = function()
				local nullls = require("null-ls")
				nullls.setup({
					sources = {
						nullls.builtins.formatting.stylua,
						nullls.builtins.formatting.prettierd,
					},
				})
			end,
		},
		{
			"jay-babu/mason-null-ls.nvim",
			dependencies = {
				"williamboman/mason.nvim",
				"jose-elias-alvarez/null-ls.nvim",
			},
			init = function()
				vim.api.nvim_create_autocmd("User", {
					pattern = "LanguagesSetupCompleted",
					callback = function()
						require("mason-null-ls").setup({
							automatic_installation = true,
						})
					end,
				})
			end,
		},
	}
end

return M
