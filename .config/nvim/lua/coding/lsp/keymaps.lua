local M = {}

local function init()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			if vim.bo[bufnr].filetype == "Octo" then
				return
			end

			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, desc = "Hover", buffer = bufnr })
			-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { silent = true, desc = "Signature", buffer = bufnr })

			if client.name ~= "omnisharp" then
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, desc = "Definition", buffer = bufnr })
			end

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "Declaration", buffer = bufnr })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true, desc = "Implementation", buffer = bufnr })
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { silent = true, desc = "Type Definition", buffer = bufnr })
			-- vim.keymap.set("n", "gr", "<CMD>Lspsaga lsp_finder<CR>", { silent = true, desc = "References", buffer = bufnr })

			vim.keymap.set("n", "gr", function() vim.lsp.buf.references({ include_declaration = false, show_line = false }) end, { silent = true, desc = "References", buffer = bufnr })
			-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "Code Actions", buffer = bufnr })
			-- vim.keymap.set({ "x", "v" }, "<leader>ca", vim.lsp.buf.range_code_action, { silent = true, desc = "Code Actions", buffer = bufnr })

			vim.keymap.set("n", "<leader>cR", function()
				vim.diagnostic.reset()
				vim.lsp.stop_client(vim.lsp.get_active_clients())
				vim.cmd("edit")
			end, { silent = true, desc = "Restart LSP", buffer = bufnr })
			vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.refresh, { silent = true, desc = "Refresh CodeLens", buffer = bufnr })
			vim.keymap.set("n", "<leader>fm", function() require("telescope.builtin").lsp_document_symbols({ symbols = { "Method", "Function" } }) end, { silent = true, desc = "Find Methods", buffer = bufnr })

			vim.keymap.set("n", "<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, { silent = true, desc = "Find Symbols", buffer = bufnr })

			vim.keymap.set("n", "<leader>ft", require("telescope.builtin").lsp_workspace_symbols, { silent = true, desc = "Find Types", buffer = bufnr })

			vim.keymap.set("n", "<leader>fi", vim.lsp.buf.incoming_calls, { silent = true, desc = "Incoming Calls", buffer = bufnr })
			vim.keymap.set("n", "<leader>fo", vim.lsp.buf.outgoing_calls, { silent = true, desc = "Outgoing Calls", buffer = bufnr })

			vim.keymap.set("n", "<leader>pp", "<CMD>Lspsaga peek_definition<CR>", { silent = true, desc = "Peek Definition", buffer = bufnr })
		end,
	})
end

function M.get_plugin_specs()
	init()
	return {}
end

return M
