local M = {}

local function init()
  vim.keymap.set("n", "<leader>uf", function() require("neotest").run.run(vim.fn.expand("%")) end, { silent = true, desc = "Test File" })
  vim.keymap.set("n", "<leader>uu", function() require("neotest").run.run() end, { silent = true, desc = "Test Nearest" })
  vim.keymap.set("n", "<leader>uU", function() require("neotest").run.run({ suite = true }) end, { silent = true, desc = "Test Suite" })
  vim.keymap.set("n", "<leader>us", function() require("neotest").output_panel.open() end, { silent = true, desc = "Test Output" })
end

local function config()
  require("neotest").setup({
    adapters = {
      require("neotest-dotnet")({}),
    },
  })
end

function M.get_plugin_specs()
  return {
    {
      "nvim-neotest/neotest",
      init = init,
      config = config,
      dependencies = {
        "Issafalcon/neotest-dotnet",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      }
    }
  }
end

return M
