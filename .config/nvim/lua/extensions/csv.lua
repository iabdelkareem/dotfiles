local M = {}

function M.get_plugin_specs()
	return {
		{
			"chrisbra/csv.vim",
			cond = not require("utils").is_vscode(),
			ft = "csv",
		},
	}
end

return M
