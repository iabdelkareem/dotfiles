local utils = require("utils")

local function get_plugin_specs()
	return {
		{
			"norcalli/nvim-colorizer.lua",
			cond = not utils.is_vscode(),
			config = function() require("colorizer").setup() end,
		},
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
