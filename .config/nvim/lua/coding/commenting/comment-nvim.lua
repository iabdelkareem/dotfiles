-- Disable automatic commenting on newline
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function() vim.opt.formatoptions:remove({ "c", "r", "o" }) end,
	desc = "Set format options",
})

local function get_plugin_specs()
	return {
		{
			"numToStr/Comment.nvim",
			config = function() require("Comment").setup() end,
		},
	}
end

--- @type Module
return {
	get_plugin_specs = get_plugin_specs,
}
