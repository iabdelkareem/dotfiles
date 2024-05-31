local function config() end

local function get_plugin_specs()
	return {
		-- TODO: Configure Scope
		{
			"lukas-reineke/indent-blankline.nvim",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},
			config = function()
				-- Better indent
				vim.keymap.set("v", "<", "<gv", { silent = true })
				vim.keymap.set("v", ">", ">gv", { silent = true })

				local const = require("const")

				require("ibl").setup({
					scope = { enabled = true },
					indent = {
						char = "┊",
					},
					exclude = {
						filetypes = {
							const.special_ft.telescope_prompt,
							const.special_ft.nvim_tree,
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
			end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
