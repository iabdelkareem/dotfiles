local M = {}

-- Disable automatic commenting on newline
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function() vim.opt.formatoptions:remove({ "c", "r", "o" }) end,
	desc = "Set format options",
})

function M.get_plugin_specs()
	return {
		{
			"numToStr/Comment.nvim",
			config = function() require("Comment").setup() end,
		},
		-- TODO: Configure
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			event = "VeryLazy",
			config = function() require("todo-comments").setup() end,
		},
		-- TODO: Configure
		{
			"danymat/neogen",
			dependencies = "nvim-treesitter/nvim-treesitter",
			config = function()
				require("neogen").setup({
					snippet_engine = "luasnip",
					languages = {
						lua = {
							template = {
								annotation_convention = "emmylua",
							},
						},
						cs = {
							template = {
								annotation_convention = "xmldoc",
							},
						},
					},
				})

				local opts = { noremap = true, silent = true }
				vim.api.nvim_set_keymap("n", "<Leader>cA", ":lua require('neogen').generate()<CR>", opts)
			end,
		},
		{ "LudoPinelli/comment-box.nvim" },
	}
end

return M
