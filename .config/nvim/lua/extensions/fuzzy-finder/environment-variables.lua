local function get_plugin_specs()
	return {
		{
			"LinArcX/telescope-env.nvim",
			dependencies = {
				"nvim-telescope/telescope.nvim",
			},
			config = function()
				require("telescope").load_extension("env")
				vim.keymap.set("n", "<leader>fE", require("telescope").extensions.nerdy.nerdy, { nowait = true, silent = true, desc = "Find Environment Variables" })
			end,
		},
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
