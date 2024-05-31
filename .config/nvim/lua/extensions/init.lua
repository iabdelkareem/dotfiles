local M = {}

function M.get_plugin_specs()
	local extend_plugin_specs = vim.u.extend_plugin_specs
	local specs = {}

	extend_plugin_specs(specs, "extensions.fuzzy-finder")
	extend_plugin_specs(specs, "extensions.csv")
	extend_plugin_specs(specs, "extensions.databases")
	extend_plugin_specs(specs, "extensions.git.diffview")
	extend_plugin_specs(specs, "extensions.git.octo")
	extend_plugin_specs(specs, "extensions.git.gitsigns")
	extend_plugin_specs(specs, "extensions.git.vim-flog")
	extend_plugin_specs(specs, "extensions.harpoon")
	extend_plugin_specs(specs, "extensions.snapshots")
	extend_plugin_specs(specs, "extensions.http-client.rest-nvim")
	return specs
end

return M
