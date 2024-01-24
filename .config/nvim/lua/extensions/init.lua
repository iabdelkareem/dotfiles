local M = {}

function M.get_plugin_specs()
	local extend_plugin_specs = vim.u.extend_plugin_specs
	local specs = {}

	extend_plugin_specs(specs, "extensions.fuzzy-finder")
	extend_plugin_specs(specs, "extensions.csv")
	extend_plugin_specs(specs, "extensions.databases")
	extend_plugin_specs(specs, "extensions.frontend")
	extend_plugin_specs(specs, "extensions.chatgpt")
	extend_plugin_specs(specs, "extensions.git")
	return specs
end

return M
