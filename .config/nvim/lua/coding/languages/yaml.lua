local M = {}

function M.get_lsp_configs()
	return {
		yamlls = {
			settings = {
				yaml = {
					schemas = require("schemastore").yaml.schemas({
						extra = {
							{
								fileMatch = { "/home/ibrahim/study/aws/**/*.yaml", "/home/ibrahim/study/aws/**/*.yml" },
								name = "AWS CloudFormation",
								url = "https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json",
								description = "",
							},
						},
					}),
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
