local M = {}

function M.get_plugin_specs()
	return {
		{
			"turbio/bracey.vim",
			cond = not require("utils").is_vscode(),
		},
	}
end

return M
