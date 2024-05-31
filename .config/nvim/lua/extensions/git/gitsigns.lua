local function get_plugin_specs()
	return {
		{
			"lewis6991/gitsigns.nvim",
			cond = not require("utils").is_vscode(),
			config = function()
				require("gitsigns").setup({
					on_attach = function(bufnr)
						local gitsigns = require("gitsigns")

						vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { noremap = true, desc = "Stage Hunk", buffer = bufnr })
						vim.keymap.set("n", "<leader>gS", gitsigns.stage_buffer, { noremap = true, desc = "Stage Buffer", buffer = bufnr })
						vim.keymap.set("n", "<leader>gu", gitsigns.undo_stage_hunk, { noremap = true, desc = "Un-Stage Hunk", buffer = bufnr })
						vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { noremap = true, desc = "Reset Hunk", buffer = bufnr })
						vim.keymap.set("n", "<leader>gR", gitsigns.reset_buffer, { noremap = true, desc = "Reset Buffer", buffer = bufnr })
						vim.keymap.set("n", "<leader>gtd", gitsigns.toggle_deleted, { noremap = true, desc = "Toggle Deleted", buffer = bufnr })
						vim.keymap.set("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { noremap = true, desc = "Toggle Line Blame", buffer = bufnr })
						vim.keymap.set("n", "<leader>gtw", gitsigns.toggle_word_diff, { noremap = true, desc = "Toggle Word Diff", buffer = bufnr })
						vim.keymap.set("n", "<leader>gtn", gitsigns.toggle_numhl, { noremap = true, desc = "Toggle Number Highlight", buffer = bufnr })
						vim.keymap.set("n", "<leader>gdd", gitsigns.preview_hunk_inline, { noremap = true, desc = "Preview Diff", buffer = bufnr })

						vim.keymap.set("n", "]h", gitsigns.next_hunk, { noremap = true, desc = "Next Hunk", buffer = bufnr })
						vim.keymap.set("n", "[h", gitsigns.prev_hunk, { noremap = true, desc = "Previous Hunk", buffer = bufnr })
					end,
				})
			end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
