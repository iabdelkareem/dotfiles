local M = {}

function M.get_plugin_specs()
  return {
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup({})
      end
    }
  }
end

return M
