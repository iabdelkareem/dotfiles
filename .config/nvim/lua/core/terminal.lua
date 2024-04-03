local M = {}

local function config_toggleterm()
	require("toggleterm").setup({
		open_mapping = [[<C-\>]],
		insert_mappings = true,
		hide_numbers = true,
		autochdir = true,
		persist_size = true,
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		close_on_exit = true,
		direction = "float",
		size = function(term)
			if term.direction == "horizontal" then
				return 20
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
	})

	vim.keymap.set("t", "<C-esc>", [[<C-\><C-n>]], { desc = "Toggle Terminal" })

	vim.keymap.set("t", "<C-Left>", function()
		local terminal = require("toggleterm.terminal").identify()
		require("toggleterm.terminal").get(terminal):change_direction("vertical")
	end)

	vim.keymap.set("n", [[<C-\>]], function()
		local terminals = require("toggleterm.terminal").get_all()
		if #terminals == 0 then
			require("toggleterm").toggle()
		else
			require("toggleterm").toggle_all()
		end
	end, { noremap = true, silent = true, nowait = true, desc = "Toggle All Terminals" })

	vim.keymap.set("n", "<leader>tt", function() require("toggleterm").toggle(vim.v.count, nil, nil, "horizontal") end, { silent = true, nowait = true, noremap = true, desc = "Toggle Terminal" })
	vim.keymap.set("n", "<leader>ts", function() require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count or 1 }) end, { silent = true, nowait = true, noremap = true, desc = "Send Line to Terminal" })

	vim.keymap.set("n", "<leader>gg", function()
		local lazygit = require("toggleterm.terminal").Terminal:new({
			cmd = "lazygit",
			open_mapping = [[<C-\>]],
			insert_mappings = true,
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			persist_size = false,
			close_on_exit = true,
			direction = "float",
		})
		lazygit:toggle()
	end, { noremap = true, silent = true, desc = "Lazygit" })
end

function M.get_plugin_specs()
	-- vim.g.kitty_navigator_no_mappings = 1
	-- vim.keymap.set("n", "<C-l>", "<cmd>KittyNavigateRight<CR>", { noremap = true })
	-- vim.keymap.set("n", "<C-h>", "<cmd>KittyNavigateLeft<CR>", { noremap = true })
	-- vim.keymap.set("n", "<C-k>", "<cmd>KittyNavigateUp<CR>", { noremap = true })
	-- vim.keymap.set("n", "<C-j>", "<cmd>KittyNavigateDown<CR>", { noremap = true })

	return {
		{
			"akinsho/toggleterm.nvim",
			cond = not require("utils").is_vscode(),
			config = config_toggleterm,
		},
		{
			"samjwill/nvim-unception",
			cond = not require("utils").is_vscode(),
			init = function() vim.g.unception_open_buffer_in_new_tab = true end,
		},
		{
			"m00qek/baleia.nvim",
			cond = not require("utils").is_vscode(),
			config = function() require("baleia").setup({}) end,
		},
		{
			"knubie/vim-kitty-navigator",
			cond = not require("utils").is_vscode(),
			lazy = false,
			build = "cp ./*.py ~/.config/kitty/",
		},
	}
end

return M
