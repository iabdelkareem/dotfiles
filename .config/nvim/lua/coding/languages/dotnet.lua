local function config_csharp()
	require("csharp").setup({
		lsp = {
			cmd_path = "/home/ibrahim/personal/repos/roslyn/artifacts/bin/Microsoft.CodeAnalysis.LanguageServer/Debug/net8.0/Microsoft.CodeAnalysis.LanguageServer.dll",
			-- cmd_path = "/home/ibrahim/personal/repos/omnisharp-roslyn/bin/release/OmniSharp",
			-- cmd_path = "/home/ibrahim/lang-server/Microsoft.CodeAnalysis.LanguageServer.dll",
			use_omnisharp = false,
		},
		logging = {
			level = "TRACE",
		},
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			if client.name ~= "omnisharp" then
				return
			end

			local get_keymap_options = function(buffer, desc) return { buffer = buffer, noremap = true, silent = true, nowait = true, desc = desc } end

			local csharp = require("csharp")
			vim.keymap.set("n", "gd", csharp.go_to_definition, get_keymap_options(bufnr, "Go to Definition"))
			vim.keymap.set("n", "<leader>cF", csharp.fix_all, get_keymap_options(bufnr, "Fix All"))
			vim.keymap.set("n", "<F5>", csharp.debug_project, get_keymap_options(bufnr, "Debug Project"))
			vim.keymap.set("n", "<c-f5>", csharp.run_project, get_keymap_options(bufnr, "Run Project"))
		end,
	})
end

local function get_plugin_specs()
	return {
		{
			"jmederosalvarado/roslyn.nvim",
			enabled = false,
			config = function() require("roslyn").setup() end,
		},
		{
			"iabdelkareem/csharp.nvim",
			enabled = true,
			dependencies = {
				"Tastyep/structlog.nvim",
			},
			dev = true,
			config = config_csharp,
		},
	}
end

vim.lsp.log.set_level("TRACE")

return {
	get_plugin_specs = get_plugin_specs,
}
