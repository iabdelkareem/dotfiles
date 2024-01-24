local M = {}

function M.get_plugin_specs()
	return {
		{ "aklt/plantuml-syntax" },
		{ "tyru/open-browser.vim" },
		{
			"weirongxu/plantuml-previewer.vim",
			config = function()
				local augroup = vim.api.nvim_create_augroup("PlantUml", { clear = true })
				vim.api.nvim_create_autocmd("FileType", {
					group = augroup,
					pattern = "plantuml",
					callback = function(args)
						vim.keymap.set("n", "<leader>pp", "<cmd>PlantumlToggle<cr>", { desc = "Preview Plantuml Toggle", buffer = args.buf, silent = true })
					end,
				})
			end,
		},
	}
end

return M
