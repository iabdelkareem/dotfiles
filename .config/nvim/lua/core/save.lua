local M = {}

function M.get_plugin_specs()
	return {
		"okuuva/auto-save.nvim",
		cond = not require("utils").is_vscode(),
		event = { "InsertLeave" },
		config = function()
			require("auto-save").setup({
				enabled = true,
				-- trigger_events = { "InsertLeave" },
			})
		end,
	}
end

return M
