local M = {}

function M.get_lsp_configs()
	return {
		yamlls = {
			settings = {
				yaml = {
					schemas = require("schemastore").yaml.schemas(),
					customTags = {
						"!Equals sequence",
						"!FindInMap sequence",
						"!GetAtt",
						"!GetAZs",
						"!ImportValue",
						"!Join sequence",
						"!Ref",
						"!Select sequence",
						"!Split sequence",
						"!Sub",
						"env-datahem-pub-macro mapping",
					},
				},
			},
		},
	}
end

return M
