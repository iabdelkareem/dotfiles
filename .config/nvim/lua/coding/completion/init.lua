local utils = require("utils")

local function get_plugin_specs()
	local specs = {}

	utils.extend_plugin_specs(specs, "coding.completion.ultimate-autopair")
	utils.extend_plugin_specs(specs, "coding.completion.nvim-cmp")
	utils.extend_plugin_specs(specs, "coding.completion.cmp-cmdline")
	utils.extend_plugin_specs(specs, "coding.completion.cmp-git")
	return specs
end

return {
	get_plugin_specs = get_plugin_specs,
}
