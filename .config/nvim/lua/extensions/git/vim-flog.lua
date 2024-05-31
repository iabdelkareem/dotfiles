local function get_plugin_specs()
	return {
		{
			"rbong/vim-flog",
			dependencies = "tpope/vim-fugitive",
			cond = not require("utils").is_vscode(),
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
