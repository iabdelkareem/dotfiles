local M = {}

local language_modules = {}

local function setup_lsp()
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	local lspconfig = require("lspconfig")
	for _, language_module in ipairs(language_modules) do
		local setup_func = language_module.get_lsp_configs
		if setup_func ~= nil then
			local configs = setup_func()
			for name, config in pairs(configs) do
				lspconfig[name].setup(vim.tbl_deep_extend("force", config, {
					capabilities = capabilities,
				}))
			end
		end
	end

	vim.api.nvim_exec_autocmds("User", { pattern = "LanguagesSetupCompleted" })
end

local function init()
	local current_file_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")

	for name, type in vim.fs.dir(current_file_path) do
		if name ~= "init.lua" then
			local module_name = string.gsub(name, ".lua", "")
			table.insert(language_modules, require("coding.languages." .. module_name))
		end
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = setup_lsp,
		desc = "Config LSP",
		once = true,
	})
end

function M.get_plugin_specs()
	init()

	local specs = {}
	local extend_plugin_specs = vim.u.extend_plugin_specs

	for _, language_module in ipairs(language_modules) do
		if language_module.get_plugin_specs ~= nil then
			extend_plugin_specs(specs, language_module)
		end
	end

	return specs
end

return M
