local M = {}

function M.get_plugin_specs()
	local specs = {}

	local extend_plugin_specs = vim.u.extend_plugin_specs
	extend_plugin_specs(specs, "coding.comments")
	extend_plugin_specs(specs, "coding.completion")
	extend_plugin_specs(specs, "coding.diagnostics")
	extend_plugin_specs(specs, "coding.indentation")
	extend_plugin_specs(specs, "coding.installer")
	extend_plugin_specs(specs, "coding.snippets")
	extend_plugin_specs(specs, "coding.lsp")
	extend_plugin_specs(specs, "coding.dap")
	extend_plugin_specs(specs, "coding.languages")
	extend_plugin_specs(specs, "coding.testing")
	extend_plugin_specs(specs, "coding.code_assistant")
	extend_plugin_specs(specs, "coding.repl")

	return specs
end

return M
