local function get_plugin_specs()
	return {
		{
			"vhyrro/luarocks.nvim",
			priority = 1000,
			config = true,
			opts = {
				rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
			},
		},
		{
			"rest-nvim/rest.nvim",
			ft = "http",
			dependencies = { "luarocks.nvim" },
			config = function()
				require("rest-nvim").setup()

				vim.api.nvim_create_autocmd("FileType", {
					pattern = { "http" },
					callback = function() vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<cr>", { noremap = true, silent = true, desc = "Run Request" }) end,
				})
			end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
