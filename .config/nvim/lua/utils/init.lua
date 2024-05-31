local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--- @return boolean
local function is_vscode()
	if vim.g.vscode then
		return true
	end
	return false
end

local function extend_plugin_specs(table, module)
	if type(module) == "string" then
		module = require(module)
	end

	return vim.list_extend(table, module.get_plugin_specs())
end

vim.u = {}
vim.u.extend_plugin_specs = extend_plugin_specs

return {
	has_words_before = has_words_before,
	is_vscode = is_vscode,
	extend_plugin_specs = extend_plugin_specs,
}
