local M = {}

function M.get_plugin_specs()
	return { { "mistricky/codesnap.nvim", build = "make", config = function() require("codesnap").setup({}) end } }
end

return M
