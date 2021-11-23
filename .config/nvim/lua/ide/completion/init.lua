local M = {
  kind_icons = require("const").completion.kind_icons,
  sources_icons = require("const").completion.source_icons,
}

function M.format(entry, vim_item)
  vim_item.menu = M.sources_icons[entry.source.name]
  vim_item.kind = M.kind_icons[vim_item.kind]
  return vim_item
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.config = function()
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  local compare = require("cmp.config.compare")

  cmp.setup({
    enabled = function()
      local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
      if in_prompt then
        return false
      end
      -- disable completion in comments
      local context = require("cmp.config.context")
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end,
    -- preselect = cmp.PreselectMode.None,
    experimental = {
      ghost_text = true,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = M.format,
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-q>"] = cmp.mapping.close(),
      ["<C-i>"] = function(callback)
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
      end,
      ["<C-j>"] = function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end,
      ["<C-k>"] = function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump(-1)
        end
      end,
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = {
      { name = "luasnip",    max_item_count = 3, group_index = 1 },
      { name = "nvim_lsp",   group_index = 1 },
      { name = "treesitter", group_index = 2 },
      { name = "path",       group_index = 2 },
      { name = "buffer",     group_index = 2,    keyword_length = 5 },
      -- { name = "spell", group_index = 2 },
      { name = "emoji",      group_index = 2 },
      { name = "calc",       group_index = 2 },
    },
  })

  cmp.setup.filetype({ "lua" }, {
    { name = "luasnip",    max_item_count = 3, group_index = 1 },
    { name = "nvim_lsp",   group_index = 1 },
    { name = "nvim_lua",   group_index = 1 },
    { name = "treesitter", group_index = 2 },
    { name = "path",       group_index = 2 },
    { name = "buffer",     group_index = 2 },
    { name = "spell",      group_index = 2 },
    { name = "emoji",      group_index = 2 },
    { name = "calc",       group_index = 2 },
  })
end

function M.get_plugin_specs()
  local specs = {
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-calc",
        "f3fora/cmp-spell",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        require("ide.completion").config()
      end,
    },
  }

  vim.u.extend_plugin_specs(specs, "ide.completion.autopairs")
  vim.u.extend_plugin_specs(specs, "ide.completion.cmdline")
  vim.u.extend_plugin_specs(specs, "ide.completion.git")
  return specs
end

return M
