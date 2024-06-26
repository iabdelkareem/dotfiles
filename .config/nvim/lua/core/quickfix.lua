local M = {}

local function config() require("bqf").setup({ func_map = {} }) end

function M.get_plugin_specs()
	return {
		{
			"kevinhwang91/nvim-bqf",
			cond = not require("utils").is_vscode(),
			config = config,
		},
	}
end

return M
