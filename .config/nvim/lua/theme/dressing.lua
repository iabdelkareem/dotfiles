local function get_plugin_specs()
	return {
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					insert_only = false,
				},
			})
		end,
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
