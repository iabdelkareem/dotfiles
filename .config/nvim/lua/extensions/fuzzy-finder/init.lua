local M = {}

local function register_keymaps()
	vim.keymap.set("n", "<leader>ff", function()
		require("extensions.fuzzy-finder.finders").find_files()
	end, { desc = "Find Files" })

	vim.keymap.set("n", "<leader>fb", function()
		require("telescope.builtin").buffers()
	end, { desc = "Find Buffers" })

	vim.keymap.set("n", "<leader>fh", function()
		require("telescope.builtin").help_tags()
	end, { desc = "Find Help" })

	vim.keymap.set("n", "<leader>fr", function()
		require("telescope.builtin").oldfiles()
	end, { desc = "Find Recent" })

	vim.keymap.set("n", "<leader>fg", function()
		require("telescope.builtin").live_grep()
	end, { desc = "Live Grep" })

	vim.keymap.set("n", "<leader>fc", function()
		require("telescope.builtin").commands()
	end, { desc = "Find Commands" })

	vim.keymap.set("n", "<leader>fw", function()
		require("telescope.builtin").current_buffer_fuzzy_find()
	end, { desc = "Current Buffer Fuzzy Find" })

	vim.keymap.set("n", "<leader>fp", function()
		require("telescope").extensions.project.project()
	end, { desc = "Find Projects" })

	vim.keymap.set("n", "<leader>fP", function()
		require("telescope.builtin").builtin()
	end, { desc = "Find Pickers" })

	vim.keymap.set("n", "<leader>fi", function()
		require("telescope.builtin").builtin.lsp_incoming_calls()
	end, { desc = "Incoming Calls" })

	vim.keymap.set("n", "<leader>fo", function()
		require("telescope.builtin").builtin.lsp_outgoing_calls()
	end, { desc = "Outgoing Calls" })

	vim.keymap.set("n", "<leader>Fr", function()
		require("extensions.fuzzy-finder.finders").find_files({ default_text = "Request" })
	end, { desc = "Find Requests" })

	vim.keymap.set("n", "<leader>FR", function()
		require("extensions.fuzzy-finder.finders").find_files({ default_text = "Repository" })
	end, { desc = "Find Repositories" })

	vim.keymap.set("n", "<leader>Fh", function()
		require("extensions.fuzzy-finder.finders").find_files({ default_text = "Handler" })
	end, { desc = "Find Handler" })

	vim.keymap.set("n", "<leader>gb", function()
		require("telescope.builtin").git_branches()
	end, { desc = "Git branches" })

	vim.keymap.set("n", "<leader>gc", function()
		require("telescope.builtin").git_commits()
	end, { desc = "Git commits" })

	vim.keymap.set("n", "<leader>fT", function()
		require("telescope.builtin").filetypes()
	end)
end

local function config()
	local actions = require("telescope.actions")
	local telescope = require("telescope")
	local custom_actions = require("extensions.fuzzy-finder.actions")

	telescope.setup({
		picker = {
			hidden = false,
		},
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--no-ignore",
				"--smart-case",
				"--hidden",
			},
			prompt_prefix = "     ",
			selection_caret = "  ",
			entry_prefix = "  ",
			sorting_strategy = "ascending",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.8,
				height = 0.8,
				preview_cutoff = 120,
			},
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = { "node_modules", ".git/", "bin/", "obj/" },
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			path_display = { "smart" },
			borderchars = { "" },
			set_env = { ["COLORTERM"] = "truecolor" },
			mappings = {
				i = {
					["<c-t>"] = require("trouble.providers.telescope").open_with_trouble,
					["<C-f>"] = actions.preview_scrolling_down,
					["<C-b>"] = actions.preview_scrolling_up,
					["<C-l>"] = actions.cycle_history_next,
					["<C-h>"] = actions.cycle_history_prev,
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			project = {
				base_dirs = {
					{ vim.fn.getenv("WORK_REPOS"), max_depth = 2 },
					{ vim.fn.getenv("PERSONAL_REPOS"), max_depth = 2 },
					{ "~/.local/share/nvim/lazy", max_depth = 3 },
				},
				order_by = "recent",
				on_project_selected = function(prompt_bufnr)
					require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr)
					require("extensions.fuzzy-finder.finders").find_files()
				end,
			},
		},
		pickers = {
			find_files = {
				mappings = {
					n = {
						["y"] = custom_actions.get_file_path,
					},
					i = {
						["<C-y>"] = custom_actions.get_file_path,
					},
				},
			},
		},
		git_files = {
			mappings = {
				n = {
					["y"] = custom_actions.get_file_path,
				},
				i = {
					["<C-y>"] = custom_actions.get_file_path,
				},
			},
		},
	})

	telescope.load_extension("fzf")
	telescope.load_extension("project") -- telescope-project.nvim
	telescope.load_extension("repo")
	telescope.load_extension("file_browser")

	-- Replace Default LSP pickers with telescope
	local builtin = require("telescope.builtin")
	vim.lsp.buf.definition = builtin.lsp_definitions
	vim.lsp.buf.implementation = builtin.lsp_implementations
	vim.lsp.buf.type_definition = builtin.lsp_type_definitions
	vim.lsp.buf.references = builtin.lsp_references
	vim.lsp.buf.incoming_calls = builtin.lsp_incoming_calls
	vim.lsp.buf.outgoing_calls = builtin.lsp_outgoing_calls
end

function M.get_plugin_specs()
	register_keymaps()

	return {
		{
			"nvim-telescope/telescope.nvim",
			config = config,
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
				"nvim-telescope/telescope-project.nvim",
				"cljoly/telescope-repo.nvim",
				"nvim-telescope/telescope-file-browser.nvim",
			},
		},
	}
end

return M
