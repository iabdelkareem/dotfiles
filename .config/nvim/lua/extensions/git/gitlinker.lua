local function get_plugin_specs()
	return {
		{
			"ruifm/gitlinker.nvim",
			cond = not require("utils").is_vscode(),
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function() require("gitlinker").setup() end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
