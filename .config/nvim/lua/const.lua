local M = {}

M.special_ft = {
  TelescopePrompt = "TelescopePrompt",
  NvimTree = "NvimTree",
  help = "help",
  packer = "packer",
  terminal = "terminal",
  nofile = "nofile",
}

M.completion = {}

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
M.dap.signs = {
  breakpoint = "",
  breakpoint_rejected = "",
  breakpoint_condition = "",
}

return M
