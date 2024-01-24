local M = {}

function M.get_lsp_configs()
	return {
		angularls = {},
		cssls = {},
		cssmodules_ls = {},
		html = {},
		svelte = {},
		tailwindcss = {},
	}
end

return M
