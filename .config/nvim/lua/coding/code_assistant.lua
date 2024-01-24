local M = {}

function M.get_plugin_specs()
	return {
		{
			"Exafunction/codeium.vim",
			init = function()
				vim.g.codeium_disable_bindings = 1
			end,
			config = function()
				vim.keymap.set("i", "<C-l>", function()
					return vim.fn["codeium#Accept"]()
				end, { expr = true })

				vim.keymap.set("i", "<C-;>", function()
					return vim.fn["codeium#CycleCompletions"](1)
				end, { expr = true })

				vim.keymap.set("i", "<C-,>", function()
					return vim.fn["codeium#CycleCompletions"](-1)
				end, { expr = true })

				vim.keymap.set("i", "<C-x>", function()
					return vim.fn["codeium#Clear"]()
				end, { expr = true })
			end,
		},
	}
end

return M
