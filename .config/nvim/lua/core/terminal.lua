local M = {}

local function config_toggleterm()
	require("toggleterm").setup({
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

	vim.keymap.set("t", "<C-esc>", [[<C-\><C-n>]], { desc = "Toggle Terminal" })

	vim.keymap.set("n", [[<C-\>]], function()
		require("toggleterm").toggle(vim.v.count)
	end, { silent = true })

	vim.keymap.set("n", "<leader>tt", function()
		require("toggleterm").toggle(vim.v.count)
	end, { silent = true })

	vim.keymap.set("n", "<leader>ts", function()
		require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count or 1 })
	end, { silent = true, desc = "Send Line to Terminal" })

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

	vim.keymap.set("n", "<leader>gg", function()
		lazygit:toggle()
	end, { noremap = true, silent = true, desc = "Lazygit" })
end

function M.get_plugin_specs()
	return {
		{
			"akinsho/toggleterm.nvim",
			config = config_toggleterm,
		},
		{
			"samjwill/nvim-unception",
			init = function()
				vim.g.unception_open_buffer_in_new_tab = true
			end,
		},
		{
			"m00qek/baleia.nvim",
			config = function()
				require("baleia").setup({})
			end,
		},
	}
end

return M
