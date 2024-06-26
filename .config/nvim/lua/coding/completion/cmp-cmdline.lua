local utils = require("utils")

local function config()
	local cmp = require("cmp")
	local mapping = cmp.mapping.preset.cmdline({
		["<TAB>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				})
			elseif utils.has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end),
	})

	-- Use buffer source for `/`
	cmp.setup.cmdline("/", {
		mapping = mapping,
		sources = {
			{ name = "nvim_lsp_document_symbol" },
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':'
	cmp.setup.cmdline(":", {
		mapping = mapping,
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

local function get_plugin_specs()
	return {
		{
			"hrsh7th/cmp-cmdline",
			config = config,
			dependencies = {
				"hrsh7th/nvim-cmp",
			},
		},
	}
end

return {
	get_plugin_specs = get_plugin_specs,
}
