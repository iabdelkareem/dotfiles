local M = {}

local function init()
	vim.g.db_ui_use_nerd_fonts = 1
	vim.g.db_ui_debug = 1
	vim.g.db_ui_force_echo_notifications = 1
	vim.g.db_ui_hide_schemas = 1
end

local function config()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "sql", "mysql", "plsql" },
		callback = function()
			require("cmp").setup.buffer({
				sources = {
					{
						name = "vim-dadbod-completion",
					},
				},
			})
		end,
	})
end

function M.get_plugin_specs()
	return {
		{
			"kristijanhusak/vim-dadbod-ui",
			cond = not require("utils").is_vscode(),
			dependencies = {
				"tpope/vim-dadbod",
				"kristijanhusak/vim-dadbod-completion",
			},
			cmd = { "DBUI" },
			init = init,
			config = config,
		},
	}
end

return M
