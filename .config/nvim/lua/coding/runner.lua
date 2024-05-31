local function get_plugin_specs()
	return { {
		"stevearc/overseer.nvim",
		config = function() require("overseer").setup() end,
	} }
end

return {
	get_plugin_specs = get_plugin_specs,
}
