local M = {}

local function on_attach(bufnr)
	local function opts(desc) return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

	require("nvim-tree.api").config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "<Right>", function() vim.cmd("vertical resize +1<CR>") end, opts("Size+"))

	vim.keymap.set("n", "<Left>", function() vim.cmd("vertical resize -1<CR>") end, opts("Size-"))
end

local function config_nvim_tree()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	vim.keymap.set("n", "<leader>fe", require("nvim-tree.api").tree.toggle, { silent = true, desc = "File Tree" })

	require("nvim-tree").setup({
		on_attach = on_attach,
		hijack_cursor = true,
		disable_netrw = true,
		sync_root_with_cwd = true,
		reload_on_bufenter = true,
		respect_buf_cwd = true,
		select_prompts = true,
		view = {
			centralize_selection = true,
			adaptive_size = true,
			relativenumber = true,
			width = {
				min = 35,
			},
		},
		renderer = {
			group_empty = true,
			full_name = true,
			special_files = {
				"Cargo.toml",
				"Makefile",
				"README.md",
				"readme.md",
				"package.json",
				"package-lock.json",
				"tsconfig.json",
				"vite.config.ts",
				"svelte.config.js",
				"playwright.config.ts",
				".prettierrc",
				".prettierignore",
				".npmrc",
				".eslintrc.cjs",
				".eslintignore",
			},
			highlight_git = "name",
			highlight_diagnostics = "all",
			highlight_bookmarks = "all",
		},
		update_focused_file = {
			enable = true,
			update_root = true,
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			severity = {
				min = vim.diagnostic.severity.WARN,
			},
		},
		filters = {
			custom = { "\\.git", "\\.vs", "bin", "obj", "node_modules", ".rollup.cache" },
		},
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
	})
end

function M.get_plugin_specs()
	return {
		{
			"kyazdani42/nvim-tree.lua",
			cond = not require("utils").is_vscode(),
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = config_nvim_tree,
		},
		{
			"stevearc/oil.nvim",
			cond = not require("utils").is_vscode(),
			config = function()
				require("oil").setup({
					default_file_explorer = false,
				})
			end,
		},
	}
end

return M
