local M = {}

function M.get_plugin_specs()
	local specs = {
		{
			"neovim/nvim-lspconfig",
		},
		{
			"williamboman/mason-lspconfig.nvim",
			dependencies = {
				"williamboman/mason.nvim",
				"neovim/nvim-lspconfig",
			},
			config = function()
				require("mason-lspconfig").setup({ automatic_installation = true })
			end,
		},
		{
			"glepnir/lspsaga.nvim",
			dependencies = { "neovim/nvim-lspconfig" },
			enabled = false,
			config = function()
				require("lspsaga").setup({
					ui = {
						code_action = "",
					},
					lightbulb = {
						virtual_text = false,
					},
					outline = {
						auto_refresh = false,
						auto_enter = false,
						auto_preview = false,
					},
					diagnostic = {
						on_insert = false,
					},
				})
			end,
		},
	}

	local extend_plugin_specs = vim.u.extend_plugin_specs
	extend_plugin_specs(specs, "ide.lsp.context")
	extend_plugin_specs(specs, "ide.lsp.formatting")
	extend_plugin_specs(specs, "ide.lsp.highlighting")
	extend_plugin_specs(specs, "ide.lsp.keymaps")
	extend_plugin_specs(specs, "ide.lsp.progress")
	extend_plugin_specs(specs, "ide.lsp.signature")
	extend_plugin_specs(specs, "ide.lsp.null-ls")
	extend_plugin_specs(specs, "ide.lsp.rename")
	-- extend_plugin_specs(specs, "ide.lsp.lens")
	return specs
end

return M
