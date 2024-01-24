local M = {}

local function setup_dap(args)
	args.dap.adapters.netcoredbg = {
		type = "executable",
		command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
		args = { "--interpreter=vscode" },
	}

	args.dap.adapters.netcoredbglambda = {
		type = "executable",
		command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
		args = { "--interpreter=vscode" },
	}

	args.dap.configurations.cs = {
		{
			type = "netcoredbg",
			name = "Attach - .NET",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
		{
			type = "netcoredbg",
			name = "Launch - .NET",
			request = "launch",
			program = function()
				return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
			end,
		},
		{
			type = "netcoredbg",
			name = "Launch - .NET 7 Lambda",
			request = "launch",
			program = function()
				return "/home/ibrahim/.dotnet/tools/.store/amazon.lambda.testtool-7.0/0.13.1/amazon.lambda.testtool-7.0/0.13.1/tools/net7.0/any/Amazon.Lambda.TestTool.BlazorTester.dll"
			end,
		},
		{
			type = "netcoredbg",
			name = "Launch - .NET 6 Lambda",
			request = "launch",
			program = function()
				return "/home/ibrahim/.dotnet/tools/.store/amazon.lambda.testtool-6.0/0.13.1/amazon.lambda.testtool-6.0/0.13.1/tools/net6.0/any/Amazon.Lambda.TestTool.BlazorTester.dll"
			end,
		},
	}
end

function M.get_plugin_specs()
	vim.keymap.set("n", "<leader>cF", function()
		local csharp = require("csharp")
		csharp.fix_all({ scope = csharp.fix_all_scope.Solution })
	end, { desc = "Fix All" })

	return {
		{
			"iabdelkareem/csharp.nvim",
			dependencies = {
				"Tastyep/structlog.nvim",
			},
			dev = true,
			config = function()
				require("csharp").setup()
			end,
		},
	}
end

return M
