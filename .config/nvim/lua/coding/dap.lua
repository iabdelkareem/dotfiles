local M = {}

local function config_dap()
	local dap = require("dap")
	local signs = require("const").dap.signs

	vim.fn.sign_define("DapBreakpoint", { text = signs.breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = signs.breakpoint, texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointCondition", { text = signs.breakpoint_rejected, texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = signs.breakpoint, texthl = "DapStoppedSign", linehl = "DapStopped", numhl = "" })

	vim.keymap.set("n", "<F5>", dap.continue, { noremap = true, silent = true, nowait = true, desc = "Debug Continue" })
	vim.keymap.set("n", "<F10>", dap.step_over, { noremap = true, silent = true, nowait = true, desc = "Step Over" })
	vim.keymap.set("n", "<F11>", function() dap.step_into({ askForTargets = true }) end, { noremap = true, silent = true, nowait = true, desc = "Step Into" })
	vim.keymap.set("n", "<S-F11>", dap.step_out, { noremap = true, silent = true, nowait = true, desc = "Step Out" })
	vim.keymap.set("n", "<leader>dR", dap.restart, { noremap = true, silent = true, nowait = true, desc = "Restart" })
	vim.keymap.set("n", "<leader>dk", dap.up, { noremap = true, silent = true, nowait = true, desc = "Up Stacktrace" })
	vim.keymap.set("n", "<leader>dj", dap.down, { noremap = true, silent = true, nowait = true, desc = "Down Stacktrace" })
	vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, { noremap = true, silent = true, nowait = true, desc = "Run to cursor" })
	vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { noremap = true, silent = true, nowait = true, desc = "Toggle Breakpoint" })
	vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { noremap = true, silent = true, nowait = true, desc = "Toggle Breakpoint" })
	vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { noremap = true, silent = true, nowait = true, desc = "Hover" })
	vim.keymap.set("n", "<Leader>dl", dap.run_last, { noremap = true, silent = true, nowait = true, desc = "Run Last Config" })
end

local function config_dap_ui()
	local dap, dapui = require("dap"), require("dapui")
	dap.listeners.before.attach.dapui_config = function() dapui.open() end
	dap.listeners.before.launch.dapui_config = function() dapui.open() end
	dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
	dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

	dapui.setup({})

	-- dapui.setup({
	-- 	layouts = {
	-- 		{
	-- 			elements = {
	-- 				{
	-- 					id = "scopes",
	-- 					size = 0.5,
	-- 				},
	-- 				{
	-- 					id = "watches",
	-- 					size = 0.5,
	-- 				},
	-- 			},
	-- 			position = "bottom",
	-- 			size = 10,
	-- 		},
	-- 	},
	-- })
	vim.keymap.set("n", "<leader>dt", function() require("dapui").toggle() end, { desc = "DapUI Toggle" })
	vim.keymap.set("n", "<leader>dW", function() require("dapui").float_element("watches") end, { desc = "Watches" })
	vim.keymap.set("n", "<leader>dR", function() require("dapui").float_element("repl") end, { desc = "Repl" })
	vim.keymap.set("n", "<leader>dB", function() require("dapui").float_element("breakpoints") end, { desc = "Breakpoints" })
	vim.keymap.set("n", "<leader>dS", function() require("dapui").float_element("stacks") end, { desc = "Stack Trace" })
end

function M.get_plugin_specs()
	return {
		{ "mfussenegger/nvim-dap", config = config_dap },
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
			config = config_dap_ui,
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			dependencies = { "mfussenegger/nvim-dap" },
			config = function() require("nvim-dap-virtual-text").setup() end,
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = {
				"williamboman/mason.nvim",
				"mfussenegger/nvim-dap",
			},
			config = function() require("mason-nvim-dap").setup({ automatic_installation = false }) end,
		},
	}
end

return M
