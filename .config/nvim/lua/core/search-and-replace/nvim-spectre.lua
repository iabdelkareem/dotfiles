-- Center search results
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true, nowait = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true, nowait = true })

-- Cancel search highlighting with ESC
vim.keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", { noremap = true, silent = true, nowait = true })

local function config()
	local spectre = require("spectre")
	spectre.setup()
	vim.keymap.set("n", "<leader>ss", spectre.open, { silent = true, noremap = true, desc = "Search & Replace" })
	vim.keymap.set({ "n", "v" }, "<leader>sw", function() spectre.open_visual({ select_word = true }) end, { desc = "Search current word" })
	vim.keymap.set("n", "<leader>sf", function() spectre.open_file_search({ select_word = true }) end, { desc = "Search on current file" })
end

local function get_plugin_specs()
	return {
		{
			"nvim-pack/nvim-spectre",
			cond = not require("utils").is_vscode(),
			config = config,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
