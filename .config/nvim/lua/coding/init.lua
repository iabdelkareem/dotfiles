local M = {}

function M.get_plugin_specs()
	local specs = {}

	if require("utils").is_vscode() then
		return {}
	end

	local extend_plugin_specs = vim.u.extend_plugin_specs
	extend_plugin_specs(specs, "coding.comments")
	extend_plugin_specs(specs, "coding.completion")
	extend_plugin_specs(specs, "coding.diagnostics")
	extend_plugin_specs(specs, "coding.indentation.indent-blankline")
	extend_plugin_specs(specs, "coding.indentation.mini-align")
	extend_plugin_specs(specs, "coding.commenting.comment-nvim")
	extend_plugin_specs(specs, "coding.commenting.neogen")
	extend_plugin_specs(specs, "coding.commenting.todo-comments")
	extend_plugin_specs(specs, "coding.commenting.comment-box")
	extend_plugin_specs(specs, "coding.mason")
	extend_plugin_specs(specs, "coding.snippets")
	extend_plugin_specs(specs, "coding.lsp")
	extend_plugin_specs(specs, "coding.dap")
	extend_plugin_specs(specs, "coding.languages")
	extend_plugin_specs(specs, "coding.testing")
	extend_plugin_specs(specs, "coding.ai.codeium")
	extend_plugin_specs(specs, "coding.repl")
	extend_plugin_specs(specs, "coding.runner")

	return specs
end

return M
