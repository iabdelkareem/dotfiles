local utils = require("utils")

local function get_plugin_specs()
	local specs = {}

	utils.extend_plugin_specs(specs, "theme.tokyonight")
	utils.extend_plugin_specs(specs, "theme.nvim-web-devicons")
	utils.extend_plugin_specs(specs, "theme.nvim-colorizer")
	utils.extend_plugin_specs(specs, "theme.dressing")
	return specs
end

return {
	get_plugin_specs = get_plugin_specs,
}
