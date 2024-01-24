local M = {}

function M.get_plugin_specs()
  vim.keymap.set("n", "<leader>rr", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { expr = true, desc = "Rename" })

  return {
    {
      "smjonas/inc-rename.nvim",
      config = function()
        require("inc_rename").setup({
          input_buffer_type = "dressing",
        })
      end,
    },
  }
end

return M
