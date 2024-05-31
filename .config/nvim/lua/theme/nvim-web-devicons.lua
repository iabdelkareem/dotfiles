local function get_plugin_specs()
	return {
		{
			"nvim-tree/nvim-web-devicons",
			cond = not require("utils").is_vscode(),
			config = function() require("nvim-web-devicons").setup({ default = true }) end,
			lazy = false,
			priority = 1000,
		},
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
