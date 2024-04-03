local function get_plugin_specs()
	return {
		"rcarriga/nvim-notify",
		cond = not require("utils").is_vscode(),
		event = "VeryLazy",
		config = function() vim.notify = require("notify") end,
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
