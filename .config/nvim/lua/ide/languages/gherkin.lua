local M = {}

function M.get_lsp_configs()
	return {
		cucumber_language_server = {
			filetypes = { "cucumber", "feature" },
			settings = {
				cucumber = {
					features = { "**/*.feature" },
					glue = { "**/*StepDefinitions.cs" },
					-- glue = { "**/*.feature.cs" },
				},
			},
		},
	}
end

return M
