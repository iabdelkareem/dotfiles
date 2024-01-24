local M = {}

function M.get_plugin_specs(use)
  return {

      {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup()
          end,
      },
  }
end

return M
