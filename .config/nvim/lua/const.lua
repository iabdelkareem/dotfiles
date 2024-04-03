local M = {}

--- @type table<string, string>
M.special_ft = {
	toggleterm = "toggleterm",
	telescope_prompt = "telescope_prompt",
	nvim_tree = "nvim_tree",
	help = "help",
	packer = "packer",
	terminal = "terminal",
	nofile = "nofile",
	diffview_files = "DiffviewFiles",
	octo_panel = "octo_panel",
	trouble = "Trouble",
}

M.completion = {}

--- @type table<string, string>
M.completion.kind_icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "",
	Variable = "󰫧",
	Class = "󰠱",
	Interface = "",
	Module = "󰕳",
	Property = "",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "",
}

--- @type table<string, string>
M.completion.source_icons = {
	nvim_lsp = "",
	nvim_lua = "",
	treesitter = "",
	path = "",
	buffer = "",
	zsh = "",
	luasnip = "",
	spell = "暈",
}

M.dap = {}
--- @type table<string, string>
M.dap.signs = {
	breakpoint = "",
	breakpoint_rejected = "",
	breakpoint_condition = "",
}

return M
