local function get_plugin_specs()
	return {
		"okuuva/auto-save.nvim",
		cond = not require("utils").is_vscode(),
		event = { "InsertLeave" },
		config = function()
			require("auto-save").setup({ enabled = true })
			vim.cmd("ASToggle")
		end,
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
