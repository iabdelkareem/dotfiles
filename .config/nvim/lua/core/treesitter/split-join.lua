local function get_plugin_specs()
	return {
		{
			"Wansmer/treesj",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			config = function()
				require("treesj").setup({
					use_default_keymaps = false,
				})

				vim.keymap.set("n", "<leader>i", require("treesj").toggle, { desc = "Split/Join" })
			end,
		},
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
