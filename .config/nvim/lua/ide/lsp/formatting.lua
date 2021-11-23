local M = {}

local function on_attach_callback(args)
	local bufnr = args.buf
	local client = vim.lsp.get_client_by_id(args.data.client_id)

	if client.server_capabilities.documentFormattingProvider then
		vim.keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>", { buffer = bufnr, silent = true, desc = "Format" })
	end
end

local function init()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = on_attach_callback,
	})
end

function M.get_plugin_specs()
	-- On type format
	-- use "yioneko/nvim-type-fmt"
	-- init()
	return {
		{
			"stevearc/conform.nvim",
			config = function()
				vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" },
						javascript = { "prettier_d" },
						typescript = { "prettier_d" },
					},
				})

				vim.keymap.set("n", "<leader>cf", function()
					require("conform").format({ timeout_ms = 1000, lsp_fallback = true, buf = 0 })
				end, { silent = true, desc = "Format" })

				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = "*",
					callback = function(args)
						if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
							return
						end

						require("conform").format({ timeout_ms = 1000, lsp_fallback = true, buf = args.buf })
					end,
				})
			end,
		},
	}
end

return M
