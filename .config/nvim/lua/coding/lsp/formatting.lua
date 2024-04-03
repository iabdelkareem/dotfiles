-- TODO: Format while typing
local M = {}

vim.api.nvim_create_user_command("FormatDisable", function(args)
	-- FormatDisable! will disable formatting just for this buffer
	if args.bang then
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable Auto Formatting",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

function M.get_plugin_specs()
	return {
		{
			"stevearc/conform.nvim",
			event = "VeryLazy",
			cmd = "ConformInfo",
			config = function()
				vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

				-- TODO: Fix trim duplicate lines
				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" },
						javascript = { "prettierd" },
						typescript = { "prettierd" },
					},
				})

				vim.keymap.set("n", "<leader>cf", function() require("conform").format({ timeout_ms = 1000, lsp_fallback = true, buf = 0 }) end, { silent = true, desc = "Format" })

				-- Format on save
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
