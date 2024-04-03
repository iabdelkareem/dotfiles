local M = {}

function M.get_lsp_configs()
	require("neodev").setup({
		setup_jsonls = false,
	})

	return {
		lua_ls = {
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
						library = {
							"/usr/share/lua/5.4/luassert",
							"$HOME/personal/repos/csharp.nvim/lua",
						},
					},
					completion = {
						workspaceWord = true,
						callSnippet = "Both",
					},
					misc = {
						parameters = {
							"--log-level=trace",
						},
					},
					diagnostics = {
						globals = {
							"describe",
							"before_each",
							"it",
							"mock",
							"assert",
						},
						groupSeverity = {
							strong = "Warning",
							strict = "Warning",
						},
						groupFileStatus = {
							["ambiguity"] = "Opened",
							["await"] = "Opened",
							["codestyle"] = "None",
							["duplicate"] = "Opened",
							["global"] = "Opened",
							["luadoc"] = "Opened",
							["redefined"] = "Opened",
							["strict"] = "Opened",
							["strong"] = "Opened",
							["type-check"] = "Opened",
							["unbalanced"] = "Opened",
							["unused"] = "Opened",
						},
						unusedLocalExclude = { "_*" },
					},
					format = {
						enable = true,
						defaultConfig = {
							indent_style = "space",
							indent_size = "2",
							continuation_indent_size = "2",
						},
					},
				},
			},
		},
	}
end

function M.get_plugin_specs()
	return {
		{
			{ "folke/neodev.nvim" },
			"rafcamlet/nvim-luapad",
			{
				"jbyuki/one-small-step-for-vimkind",
				dependencies = { "mfussenegger/nvim-dap" },
				config = function()
					local dap = require("dap")
					dap.configurations.lua = {
						{
							type = "nlua",
							request = "attach",
							name = "Attach to running Neovim instance",
						},
					}

					dap.adapters.nlua = function(callback, config) callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }) end

					vim.keymap.set("n", "<leader>dN", function() require("osv").launch({ port = 8086, log = true }) end, { noremap = true, desc = "Debug Neovim" })
				end,
			},
		},
	}
end

return M
