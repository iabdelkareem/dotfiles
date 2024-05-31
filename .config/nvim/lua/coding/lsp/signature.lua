local M = {}

function M.get_plugin_specs()
	return {
		{
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup({
					select_signature_key = "<C-j>",
					toggle_key = nil,
					bind = true,
					handler_opts = {
						border = "rounded",
					},
				})

				vim.keymap.set({ "n", "i" }, "<C-s>", function() require("lsp_signature").toggle_float_win() end, { silent = true, noremap = true, desc = "toggle signature" })
			end,
		},
	}
end

return M
