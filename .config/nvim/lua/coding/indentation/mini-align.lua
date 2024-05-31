local function get_plugin_specs()
	return { {
		"echasnovski/mini.align",
		version = false,
		config = function() require("mini.align").setup() end,
	} }
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
