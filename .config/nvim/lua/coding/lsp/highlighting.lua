local M = {}

function M.get_plugin_specs()
	return {
		{
			"RRethy/vim-illuminate",
			config = function()
				require("illuminate").configure({})
				vim.keymap.set("n", "]r", function() require("illuminate").goto_next_reference({ wrap = true }) end, { desc = "Next Reference" })

				vim.keymap.set("n", "[r", function() require("illuminate").goto_prev_reference({ reverse = true, wrap = true }) end, { desc = "Prev Reference" })
			end,
		},
		{
			"kosayoda/nvim-lightbulb",
			config = function()
				require("nvim-lightbulb").setup({
					autocmd = {
						enabled = true,
					},
				})
			end,
		},
	}
end

return M
