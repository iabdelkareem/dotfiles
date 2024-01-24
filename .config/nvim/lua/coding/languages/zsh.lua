local M = {}

function M.setup(args) end

--@return LazySpec
function M.get_plugin_specs()
  return {
    {
      "tamago324/cmp-zsh",
      ft = "zsh",
      dependencies = {
        "hrsh7th/nvim-cmp",
      },
      config = function()
        require("cmp_zsh").setup({
          zshrc = true,
          filetypes = { "zsh" },
        })

        require("cmp").setup.filetype({ "zsh" }, {
          sources = {
            { name = "zsh" },
          },
        })
      end,
    },
  }
end

return M
