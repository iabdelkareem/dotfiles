local M = {}

function M.get_plugin_specs()
  return {
      {
          "chrisbra/csv.vim",
          ft = "csv",
      }
  }
end

return M
