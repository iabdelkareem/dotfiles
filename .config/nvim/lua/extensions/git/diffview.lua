local function get_plugin_specs()
	return {
		{
			"sindrets/diffview.nvim",
			config = function()
				require("diffview").setup({ enhanced_diff_hl = true })

				vim.keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>", { noremap = true, desc = "Diffview Open" })
				vim.keymap.set("n", "<leader>gdc", "<cmd>DiffviewClose<CR>", { noremap = true, desc = "Diffview Close" })
			end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
