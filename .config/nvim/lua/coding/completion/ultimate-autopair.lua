local function get_plugin_specs()
	return {
		{
			"altermo/ultimate-autopair.nvim",
			event = { "InsertEnter", "CmdlineEnter" },
			branch = "v0.6", --recommended as each new version will have breaking changes
			config = function()
				require("ultimate-autopair").setup({
					space2 = { enable = true },
					tabout = { enable = true, hopout = true },
					close = { enable = true },
					fastwarp = {
						faster = true,
					},
					bs = {
						indent_ignore = true,
					},
					cr = {
						autoclose = true,
					},
				})
			end,
		},
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
