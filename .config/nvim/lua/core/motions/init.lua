local M = {}

function M.get_plugin_specs()
	local specs = {
		{
			"kylechui/nvim-surround",
			config = function()
				require("nvim-surround").setup()
			end,
		},
		{ "wellle/targets.vim" },
		{ "chaoren/vim-wordmotion" },
		{ "tpope/vim-repeat" },
		-- {
		--   "chrisgrieser/nvim-various-textobjs",
		--   config = function()
		--     require("various-textobjs").setup({ useDefaultKeymaps = true })
		--   end,
		-- },
	}

	vim.u.extend_plugin_specs(specs, "core.motions.leap")
	return specs
end

return M
