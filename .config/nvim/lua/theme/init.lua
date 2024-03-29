local M = {}

function M.get_plugin_specs()
  local specs = {
    {
      {
        "nvim-tree/nvim-web-devicons",
        config = function()
          require("nvim-web-devicons").setup({ default = true })
        end,
        lazy = false,
        priority = 1000,
      },
      {
        "norcalli/nvim-colorizer.lua",
        config = function()
          require("colorizer").setup()
        end,
      },
      "stevearc/dressing.nvim",
    },
  }

  -- vim.u.extend_plugin_specs(specs, "theme.vscode")
  vim.u.extend_plugin_specs(specs, "theme.darkplus")
  return specs
end

return M
