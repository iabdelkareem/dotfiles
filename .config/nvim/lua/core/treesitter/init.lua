local M = {}

local function config()
	---@diagnostic disable-next-line: missing-fields
	require("nvim-treesitter.configs").setup({
		ensure_installed = "all",
		sync_install = true,
		ignore_install = { "tree-sitter-wing" },
		auto_install = true,
		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},

		highlight = {
			-- `false` will disable the whole extension
			enable = true,
			-- disable = { "sh" },
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		autotag = {
			enable = true,
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				node_incremental = "<CR>",
				node_decremental = "<BS>",
			},
		},

		indent = { enable = true },

		-- vim-matchup
		matchup = {
			enable = false,
			disable = { "svelte" },
		},

		-- nvim-treesitter-textobjects
		textobjects = {
			select = {
				enable = true,
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["aC"] = "@class.outer",
					["iC"] = "@class.inner",
					["ap"] = "@parameter.outer",
					["ip"] = "@parameter.inner",
					["aa"] = "@assignment.outer",
					["ia"] = "@assignment.inner",
					["ah"] = "@assignment.left",
					["al"] = "@assignment.right",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["ac"] = "@conditional.outer",
					["ic"] = "@conditional.inner",
					["as"] = "@statement.outer",
					["ii"] = "@call.inner",
					["ai"] = "@call.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					[">p"] = "@parameter.inner",
					[">f"] = "@function.outer",
				},
				swap_previous = {
					["<p"] = "@parameter.inner",
					["<f"] = "@function.outer",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]f"] = "@function.outer",
					["]if"] = "@function.inner",
					["]p"] = "@parameter.outer",
					["]c"] = "@conditional.outer",
					["]l"] = "@loop.outer",
					["]t"] = "@class.outer",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]iF"] = "@function.inner",
					["]P"] = "@parameter.outer",
					["]c"] = "@conditional.outer",
					["]L"] = "@loop.outer",
					["]T"] = "@class.outer",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[if"] = "@function.inner",
					["[p"] = "@parameter.outer",
					["[c"] = "@conditional.outer",
					["[l"] = "@loop.outer",
					["[t"] = "@class.outer",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[iF"] = "@function.inner",
					["[P"] = "@parameter.outer",
					["[C"] = "@conditional.outer",
					["[L"] = "@loop.outer",
					["[T"] = "@class.outer",
				},
			},
			lsp_interop = {
				enable = true,
				border = "single",
				peek_definition_code = {
					["<leader>pf"] = "@function.outer",
					["<leader>pc"] = "@class.outer",
				},
			},
		},
		endwise = {
			enable = true,
		},
	})
end

function M.get_plugin_specs()
	local plugins = {
		{
			"nvim-treesitter/nvim-treesitter",
			dependencies = {
				"nvim-treesitter/nvim-treesitter-textobjects",
				-- "p00f/nvim-ts-rainbow",
				"RRethy/nvim-treesitter-endwise",
				"windwp/nvim-ts-autotag",
				"nvim-treesitter/playground",
				-- "andymass/vim-matchup",
			},
			config = config,
		},
		{
			"theRealCarneiro/hyprland-vim-syntax",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			ft = "hypr",
		},
	}

	return vim.u.extend_plugin_specs(plugins, "core.treesitter.split-join")
end

return M
