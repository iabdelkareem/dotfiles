local function get_plugin_specs()
	return {
		{
			"pwntester/octo.nvim",
			cond = not require("utils").is_vscode(),
			config = function()
				require("octo").setup()
				vim.keymap.set("n", "<leader>gp", "<cmd>Octo pr list<CR>", { noremap = true, desc = "List PRs" })
			end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
