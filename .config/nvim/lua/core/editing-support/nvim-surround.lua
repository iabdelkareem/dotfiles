local function get_plugin_specs()
	return { {
		"kylechui/nvim-surround",
		config = function() require("nvim-surround").setup() end,
	} }
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
