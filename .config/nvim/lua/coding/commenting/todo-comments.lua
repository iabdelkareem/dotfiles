local function get_plugin_specs()
	return {
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			event = "VeryLazy",
			config = function() require("todo-comments").setup() end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
