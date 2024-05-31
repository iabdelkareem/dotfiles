local M = {}

function M.get_plugin_specs()
	local extend_plugin_specs = vim.u.extend_plugin_specs
	local plugins = {}

	extend_plugin_specs(plugins, "core.keymaps")
	extend_plugin_specs(plugins, "core.file-management.nvim-tree")
	extend_plugin_specs(plugins, "core.file-management.oil-nvim")
	extend_plugin_specs(plugins, "core.motions.targets-vim")
	extend_plugin_specs(plugins, "core.motions.vim-wordmotion")
	extend_plugin_specs(plugins, "core.motions.vim-repeat")
	extend_plugin_specs(plugins, "core.motions.leap")
	extend_plugin_specs(plugins, "core.editing-support.nvim-surround")
	extend_plugin_specs(plugins, "core.tab-line")
	extend_plugin_specs(plugins, "core.status-line.lualine")
	extend_plugin_specs(plugins, "core.layout")
	extend_plugin_specs(plugins, "core.sessions")
	extend_plugin_specs(plugins, "core.terminal")
	extend_plugin_specs(plugins, "core.treesitter")
	extend_plugin_specs(plugins, "core.search-and-replace.nvim-spectre")
	extend_plugin_specs(plugins, "core.quickfix")
	extend_plugin_specs(plugins, "core.auto-save.auto-save")
	extend_plugin_specs(plugins, "core.folding.nvim-ufo")
	extend_plugin_specs(plugins, "core.dashboard.mini-starter")
	extend_plugin_specs(plugins, "core.notifications.nvim-notify")
	return plugins
end

return M
