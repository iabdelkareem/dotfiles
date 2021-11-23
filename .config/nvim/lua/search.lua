local M = {}

local function config()
  vim.keymap.set("n", "<leader>S", require("spectre").open, { silent = true, noremap = true, desc = "Search & Replace" })
  require('spectre').setup()
end

function M.get_plugin_specs()
  return {
    {
      "nvim-pack/nvim-spectre",
      config = config
    }
  }
end

return M
