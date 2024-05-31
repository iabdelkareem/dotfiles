local M = {}

function M.get_lsp_configs()
	return {
		angularls = {},
		cssls = {
			filetypes = { "css", "scss", "less" },
		},
		cssmodules_ls = {
			filetypes = { "css", "scss", "less" },
		},
		html = {
			filetypes = { "html", "svelte" },
		},
		svelte = {},
		tailwindcss = {
			hovers = true,
			suggestions = true,
			root_dir = function(fname)
				local root_pattern = require("lspconfig").util.root_pattern("tailwind.config.cjs", "tailwind.config.js", "postcss.config.js")
				return root_pattern(fname)
			end,
		},
	}
end

function M.get_plugin_specs()
	return {
		{
			"brenoprata10/nvim-highlight-colors",
			config = function()
				require("nvim-highlight-colors").setup({
					render = "virtual",
					enable_named_colors = true,
					enable_tailwind = true,
				})
			end,
		},
		{
			"turbio/bracey.vim",
			cond = not require("utils").is_vscode(),
		},
		{
			"vuki656/package-info.nvim",
			dependencies = { "MunifTanjim/nui.nvim" },
			config = function()
				local package_info = require("package-info")
				package_info.setup()
				local get_keymap_options = function(desc) return { noremap = true, silent = true, nowait = true, desc = desc } end
				vim.keymap.set("n", "<leader>cps", package_info.show, get_keymap_options("Show Package Info"))
				vim.keymap.set("n", "<leader>cpS", function() package_info.show({ force = true }) end, get_keymap_options("Show Package Info (Refresh)"))
				vim.keymap.set("n", "<leader>cpd", package_info.delete, get_keymap_options("Delete Package"))
				vim.keymap.set("n", "<leader>cpc", package_info.change_version, get_keymap_options("Change Package Version"))
				vim.keymap.set("n", "<leader>cpi", package_info.install, get_keymap_options("Install Package"))
			end,
		},
	}
end

return M
