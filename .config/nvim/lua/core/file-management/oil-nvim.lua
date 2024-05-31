local function get_plugin_specs()
	return { {
		"stevearc/oil.nvim",
		cond = not require("utils").is_vscode(),
		config = function()
			require("oil").setup({
				default_file_explorer = false,
			})
		end,
	} }
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
