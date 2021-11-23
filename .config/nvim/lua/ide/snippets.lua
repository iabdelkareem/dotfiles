local M = {}

function M.config()
  require("luasnip").config.set_config {
    history = false,
  }

  require("luasnip.loaders.from_vscode").load()
end

function M.get_plugin_specs()
  return {
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      config = function()
        require("ide.snippets").config()
      end
    }
  }
end

return M
