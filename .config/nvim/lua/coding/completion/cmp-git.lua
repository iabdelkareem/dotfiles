local function config()
	require("cmp").setup.filetype({ "git", "gitrebase", "gitcommit", "octo" }, {
		sources = {
			{ name = "git" },
			{ name = "emoji" },
		},
	})

	require("cmp_git").setup()
end

local function get_plugin_specs()
	return {
		{
			"petertriho/cmp-git",
			config = config,
			dependencies = {
				"hrsh7th/nvim-cmp",
			},
		},
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
