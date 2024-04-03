local function config()
	local harpoon = require("harpoon")
	harpoon:setup()

	-- basic telescope configuration
	local conf = require("telescope.config").values
	local function toggle_telescope(harpoon_files)
		local file_paths = {}
		for _, item in ipairs(harpoon_files.items) do
			table.insert(file_paths, item.value)
		end

		require("telescope.pickers")
			.new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			})
			:find()
	end

	vim.keymap.set("n", "`", function() harpoon:list():append() end, { desc = "Add file to Harpoon", nowait = true, silent = true, noremap = true })
	vim.keymap.set("n", "<F1>", function() toggle_telescope(harpoon:list()) end, { desc = "Harpoon Quickmenu", nowait = true, silent = true, noremap = true })
end

local function get_plugin_specs()
	return { {
		"ThePrimeagen/harpoon",
		cond = not require("utils").is_vscode(),
		config = config,
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	} }
end

return {
	get_plugin_specs = get_plugin_specs,
}
