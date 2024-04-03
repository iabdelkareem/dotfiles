local M = {}

-- Color table for highlights
local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

local function separator() return "%=" end

local function lsp_client(msg)
	msg = msg or ""
	local buf = vim.api.nvim_get_current_buf()
	local buf_clients = vim.lsp.get_active_clients({ bufnr = buf })
	if next(buf_clients) == nil then
		if type(msg) == "boolean" or #msg == 0 then
			return ""
		end
		return msg
	end

	--local buf_ft = vim.bo.filetype
	local buf_client_names = {}

	-- add client
	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end

	return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

local function current_buffer() return vim.api.nvim_get_current_buf() end

local function config()
	local code_context = require("coding.lsp.context")

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "codedark",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {},
			always_divide_middle = true,
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				"branch",
				"diff",
				{
					"diagnostics",
					sources = { "nvim_workspace_diagnostic" },
					sections = { "error", "warn" },
				},
			},
			lualine_c = {
				{ code_context.get_context, code_context.is_available },
			},
			lualine_x = {
				{
					lsp_client,
					icon = " ",
					color = { fg = colors.violet, gui = "bold" },
				},
				"filename",
				"encoding",
				"fileformat",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { current_buffer, "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	})
end

function M.get_plugin_specs()
	return {
		{
			"nvim-lualine/lualine.nvim",
			cond = not require("utils").is_vscode(),
			config = config,
		},
	}
end

return M
