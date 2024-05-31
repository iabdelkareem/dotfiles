local function get_plugin_specs()
	return {
		{
			"williamboman/mason.nvim",
			config = function() require("mason").setup({}) end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
