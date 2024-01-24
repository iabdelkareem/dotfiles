local M = {}

function M.get_plugin_specs()
  return {
    "mfussenegger/nvim-dap",
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap" },
      config = function()
        local dapui = require("dapui")

        require("dap").set_log_level("DEBUG")

        dapui.setup({
          layouts = {
            {
              elements = {
                {
                  id = "scopes",
                  size = 0.5,
                },
                {
                  id = "watchers",
                  size = 0.5,
                },
              },
              position = "bottom",
              size = 10,
            },
          },
        })
        local dap = require("dap")

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end

        vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug Continue" })
        vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
        vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
        vim.keymap.set("n", "<S-F11>", dap.step_out, { desc = "Step Out" })
        vim.keymap.set("n", "<leader>dR", dap.restart, { desc = "Restart" })

        vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Up Stacktrace" })
        vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Down Stacktrace" })
        vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, { desc = "Run to cursor" })
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
        vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "Hover" })

        vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last Config" })

        vim.keymap.set("n", "<leader>dtw", function()
          require("dapui").float_element("watches")
        end, { desc = "Watches" })

        vim.keymap.set("n", "<leader>dtr", function()
          require("dapui").float_element("repl")
        end, { desc = "Repl" })

        vim.keymap.set("n", "<leader>dtb", function()
          require("dapui").float_element("breakpoints")
        end, { desc = "Breakpoints" })

        vim.keymap.set("n", "<leader>dts", function()
          require("dapui").float_element("stacks")
        end, { desc = "Stack Trace" })

        local const = require("const")
        vim.fn.sign_define("DapBreakpoint", { text = const.dap.signs.breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointRejected", { text = const.dap.signs.breakpoint, texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition", { text = const.dap.signs.breakpoint_rejected, texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = const.dap.signs.breakpoint, texthl = "DapStoppedSign", linehl = "DapStopped", numhl = "" })
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      dependencies = { "mfussenegger/nvim-dap" },
      config = function()
        require("nvim-dap-virtual-text").setup()
      end,
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
      },
      config = function()
        require("mason-nvim-dap").setup({ automatic_installation = false })
      end,
    },
  }
end

return M
