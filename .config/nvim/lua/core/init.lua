local M = {}

function M.get_plugin_specs()
	local extend_plugin_specs = vim.u.extend_plugin_specs
	local plugins = {}

	extend_plugin_specs(plugins, "core.keymaps")
	extend_plugin_specs(plugins, "core.file-tree")
	extend_plugin_specs(plugins, "core.motions")
	extend_plugin_specs(plugins, "core.tab-line")
	extend_plugin_specs(plugins, "core.status-line")
	extend_plugin_specs(plugins, "core.layout")
	extend_plugin_specs(plugins, "core.sessions")
	extend_plugin_specs(plugins, "core.terminal")
	extend_plugin_specs(plugins, "core.treesitter")
	extend_plugin_specs(plugins, "core.search")
	extend_plugin_specs(plugins, "core.quickfix")
	extend_plugin_specs(plugins, "core.save")
	extend_plugin_specs(plugins, "core.folding")
	extend_plugin_specs(plugins, "core.welcome-screen")
	extend_plugin_specs(plugins, "core.notifications")
	return plugins
end

return M
