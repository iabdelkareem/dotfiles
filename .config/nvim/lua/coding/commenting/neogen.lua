local function get_plugin_specs()
	return {
		{
			"danymat/neogen",
			dependencies = "nvim-treesitter/nvim-treesitter",
			config = function()
				require("neogen").setup({
					snippet_engine = "nvim",
				})

				local opts = { noremap = true, silent = true }
				vim.api.nvim_set_keymap("n", "<Leader>cA", ":lua require('neogen').generate()<CR>", opts)
			end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
