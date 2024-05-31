local function get_plugin_specs()
	return {
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				require("tokyonight").setup({
					style = "storm",
				})

				vim.cmd([[colorscheme tokyonight]])
			end,
		},
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
