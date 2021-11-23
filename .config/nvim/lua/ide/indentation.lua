local M = {}

local function config()
	local const = require("const")

	require("ibl").setup({
		indent = {
			char = "┊",
		},
		exclude = {
			filetypes = {
				const.special_ft.TelescopePrompt,
				const.special_ft.NvimTree,
				const.special_ft.help,
				"txt",
				"markdown",
				"dashboard",
			},
			buftypes = {
				const.special_ft.nofile,
				const.special_ft.terminal,
			},
		},
	})
end

function M.get_plugin_specs()
	return {
		{
			"lukas-reineke/indent-blankline.nvim",
			config = config,
		},
		{
			"junegunn/vim-easy-align",
		},
	}
end

return M
