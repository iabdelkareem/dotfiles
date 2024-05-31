local utils = require("utils")

local kind_icons = require("const").completion.kind_icons
local sources_icons = require("const").completion.source_icons

local function has_words_before()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--- @return vim.CompletedItem
local function format(entry, vim_item)
	local kind_name = vim_item.kind
	vim_item.menu = sources_icons[entry.source.name]
	vim_item.kind = (kind_icons[kind_name] or "") .. " [" .. (kind_name or "") .. "]"
	return vim_item
end

--- @return boolean
local function enabled()
	local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
	if in_prompt then
		return false
	end
	-- disable completion in comments
	-- local context = require("cmp.config.context")
	-- -- keep command mode completion enabled when cursor is in a comment
	-- if vim.api.nvim_get_mode().mode == "c" then
	-- 	return true
	-- else
	-- 	return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
	-- end

	return true
end

local function get_mappings()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	return cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-q>"] = cmp.mapping.close(),
		["<C-i>"] = function(callback) cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }) end,
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
			elseif vim.snippet.active({ direction = 1 }) then
				vim.snippet.jump(1)
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
			elseif vim.snippet.active({ direction = -1 }) then
				vim.snippet.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	})
end

local function get_sources()
	return {
		{ name = "nvim_lsp", group_index = 1 },
		{ name = "treesitter", group_index = 2 },
		{ name = "path", group_index = 2 },
		{ name = "buffer", group_index = 2, keyword_length = 5 },
		{ name = "emoji", group_index = 2 },
		{ name = "calc", group_index = 2 },
	}
end

local function config()
	local cmp = require("cmp")

	cmp.setup({
		enabled = enabled,
		snippet = {
			expand = function(args) vim.snippet.expand(args.body) end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		experimental = {
			ghost_text = true,
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			expandable_indicator = true,
			format = format,
		},
		mapping = get_mappings(),
		sources = get_sources(),
	})

	cmp.setup.filetype({ "lua" }, {
		{ name = "nvim_lsp", group_index = 1 },
		{ name = "nvim_lua", group_index = 1 },
		{ name = "treesitter", group_index = 2 },
		{ name = "path", group_index = 2 },
		{ name = "buffer", group_index = 2 },
		{ name = "spell", group_index = 2 },
		{ name = "emoji", group_index = 2 },
		{ name = "calc", group_index = 2 },
	})
end

local function get_plugin_specs()
	return {
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
			config = config,
		},
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
