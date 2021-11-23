local M = {}

function M.get_plugin_specs()
  return {
      {
          "ray-x/lsp_signature.nvim",
          config = function()
            require 'lsp_signature'.setup({
                select_signature_key = "<C-j>",
                toggle_key = "<C-k>",
                bind = true,
                handler_opts = {
                    border = "rounded",
                }
            })
          end
      },
  }
end

return M
