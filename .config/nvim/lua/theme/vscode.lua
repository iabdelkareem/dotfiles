local M = {}

local function config_highlights()
	vim.api.nvim_set_hl(0, "@keyword", { fg = "#569CD6" })
	-- Lsp
	vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#d8d8d8", bg = "#3a3a3a" })

	-- Diagnostics
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = 1, fg = "#db4b4b", sp = "#db4b4b" })
	vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#ffbb61" })

	-- Leap
	vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#6C7A96" })
	vim.api.nvim_set_hl(0, "LeapMatch", {
		fg = "white",
		bold = true,
		nocombine = true,
	})

	vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
		fg = "#AAFF00",
		bold = true,
		nocombine = true,
	})

	-- Dap
	vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#b92e11" })
	vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#182f8a" })
	vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#c3bb20" })
	vim.api.nvim_set_hl(0, "DapStopped", { bg = "#edd731", fg = "#000000" })
	vim.api.nvim_set_hl(0, "DapStoppedSign", { fg = "#e7e87a" })
end

local function config()
	vim.o.background = "dark"
	require("vscode").load({
		italic_comments = true,
	})

	config_highlights()
end

function M.get_plugin_specs()
	return {
		{
			"Mofiqul/vscode.nvim",
			config = config,
			priority = 1001,
		},
	}
end

return M
