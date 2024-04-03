local function get_plugin_specs()
	return {
		{
			"https://github.com/2KAbhishek/nerdy.nvim",
			dependencies = {
				"stevearc/dressing.nvim",
				"nvim-telescope/telescope.nvim",
			},
			config = function()
				require("telescope").load_extension("nerdy")
				vim.keymap.set("n", "<leader>fn", require("telescope").extensions.nerdy.nerdy, { nowait = true, silent = true, desc = "Find Nerd Glyphs" })
			end,
		},
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
