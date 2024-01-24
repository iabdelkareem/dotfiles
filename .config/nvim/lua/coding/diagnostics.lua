local M = {}

local register_keymaps = function()
	vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { noremap = true, desc = "Show Diagnostics" })
	vim.keymap.set("n", "]e", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { noremap = true, desc = "Next Error" })
	vim.keymap.set("n", "[e", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { noremap = true, desc = "Prev Error" })
	vim.keymap.set("n", "]w", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	end, { noremap = true, desc = "Next Warning" })
	vim.keymap.set("n", "[w", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
	end, { noremap = true, desc = "Prev Warning" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, desc = "Next Diagnostic" })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, desc = "Next Diagnostic" })
end

local function config_diagnostics()
	local diagnostic_signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
	}
	for _, sign in ipairs(diagnostic_signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
		},
		signs = {
			severity = { min = vim.diagnostic.severity.INFO },
		},
		underline = {
			severity = { min = vim.diagnostic.severity.INFO },
		},
		update_in_insert = true,
	})
end

local function init()
	register_keymaps()
	config_diagnostics()

	local group = vim.api.nvim_create_augroup("TroubleKeyMaps", { clear = false })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = "Trouble",
		callback = function(args)
			local trouble = require("trouble")
			vim.keymap.set("n", "]t", function()
				trouble.next({ skip_groups = true, jump = false })
			end, { buffer = args.buf, desc = "Next Entry" })

			vim.keymap.set("n", "[t", function()
				trouble.previous({ skip_groups = true, jump = false })
			end, { buffer = args.buf, desc = "Previous Entry" })
		end,
		desc = "Trouble Keymaps",
	})
end

function M.get_plugin_specs()
	init()
	return {
		{
			"folke/trouble.nvim",
			config = function()
				require("trouble").setup()
				vim.keymap.set("n", "<leader>dD", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Workspace Diagnostics" })
			end,
		},
	}
end

return M
