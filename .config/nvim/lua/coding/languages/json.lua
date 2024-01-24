local M = {}

function M.get_lsp_configs()
	return {
		jsonls = {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		},
	}
end

function M.get_plugin_specs()
	return {
		"b0o/SchemaStore.nvim",
	}
end

return M
