local M = {}

function M.get_plugin_specs()
  return {
      {
          "numToStr/Comment.nvim",
          config = function()
            require("Comment").setup()
          end
      },
      {
          "danymat/neogen",
          dependencies = "nvim-treesitter/nvim-treesitter",
          config = function()
            require("neogen").setup({
                snippet_engine = "luasnip",
                languages = {
                    lua = {
                        template = {
                            annotation_convention = "emmylua"
                        }
                    },
                    cs = {
                        template = {
                            annotation_convention = "xmldoc"
                        }
                    }
                }
            })

            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<Leader>cA", ":lua require('neogen').generate()<CR>", opts)
          end,
      },
  }
end

return M
