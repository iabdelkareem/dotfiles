local M = {}

function M.get_plugin_specs()
	local specs = {}

	local extend_plugin_specs = vim.u.extend_plugin_specs
	extend_plugin_specs(specs, "ide.comments")
	extend_plugin_specs(specs, "ide.completion")
	extend_plugin_specs(specs, "ide.diagnostics")
	extend_plugin_specs(specs, "ide.indentation")
	extend_plugin_specs(specs, "ide.installer")
	extend_plugin_specs(specs, "ide.snippets")
	extend_plugin_specs(specs, "ide.treesitter")
	extend_plugin_specs(specs, "ide.lsp")
	extend_plugin_specs(specs, "ide.dap")
	extend_plugin_specs(specs, "ide.languages")
	extend_plugin_specs(specs, "ide.testing")
	extend_plugin_specs(specs, "ide.code_assistant")
	extend_plugin_specs(specs, "ide.repl")

	return specs
end

return M
