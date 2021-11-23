local M = {}

local function config()
  require("telescope").load_extension("projects")
  require("project_nvim").setup({
    detection_methods = { "pattern" },
    patterns = { ".git" },
    show_hidden = true,
  })
end

function M.get_plugin_specs(use)
  return {
    {
      "ahmedkhalf/project.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
      },
      config = config,
    },
  }
end

return M
