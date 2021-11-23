local M = {}

function M.get_lsp_configs()
	return {
		bicep = {},
		dockerls = {},
		ltex = {},
		prismals = {},
		sqlls = {},
		vimls = {},
		lemminx = {},
		bufls = {},
	}
end

return M
