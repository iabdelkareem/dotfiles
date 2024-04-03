local M = {}

local function get_highlight(name) return vim.api.nvim_get_hl(0, { name = name }) end

vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = get_highlight("CursorLine").bg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = get_highlight("CursorLine").bg, fg = get_highlight("Comment").fg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = get_highlight("Function").fg, bg = get_highlight("CursorLine").bg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = get_highlight("Type").fg, bg = get_highlight("CursorLine").bg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = get_highlight("@keyword").fg, bg = get_highlight("CursorLine").bg, italic = true })

local function text_format_visuals(symbol)
	local res = {}

	local round_start = { "", "SymbolUsageRounding" }
	local round_end = { "", "SymbolUsageRounding" }

	if symbol.references then
		local usage = symbol.references <= 1 and "usage" or "usages"
		local num = symbol.references == 0 and "no" or symbol.references
		table.insert(res, round_start)
		table.insert(res, { "󰌹 ", "SymbolUsageRef" })
		table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
		table.insert(res, round_end)
	end

	if symbol.definition then
		if #res > 0 then
			table.insert(res, { " ", "NonText" })
		end
		table.insert(res, round_start)
		table.insert(res, { "󰳽 ", "SymbolUsageDef" })
		table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
		table.insert(res, round_end)
	end

	if symbol.implementation then
		if #res > 0 then
			table.insert(res, { " ", "NonText" })
		end
		table.insert(res, round_start)
		table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
		table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
		table.insert(res, round_end)
	end

	return res
end

local function text_format(symbol)
	local fragments = {}

	if symbol.references then
		local usage = symbol.references <= 1 and "usage" or "usages"
		local num = symbol.references == 0 and "no" or symbol.references
		table.insert(fragments, ("%s %s"):format(num, usage))
	end

	if symbol.definition then
		table.insert(fragments, symbol.definition .. " defs")
	end

	if symbol.implementation then
		table.insert(fragments, symbol.implementation .. " impls")
	end

	return table.concat(fragments, ", ")
end

local function config() require("symbol-usage").setup({ text_format = text_format }) end

function M.get_plugin_specs()
	return {
		{ "Wansmer/symbol-usage.nvim", config = config, enabled = false },
	}
end

return M
