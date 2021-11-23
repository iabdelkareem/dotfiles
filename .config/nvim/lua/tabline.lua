local M = {}

local function register_keymaps()
  vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<CR>", { noremap = true, desc = "Next Buffer" })
  vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<CR>", { noremap = true, desc = "Next Buffer" })
  vim.keymap.set("n", ">b", "<cmd>BufferLineMoveNext<CR>", { noremap = true, desc = "Shift Buffer" })
  vim.keymap.set("n", "]q", "<cmd>BufferLineCloseRight<CR>", { noremap = true, desc = "Close Right Buffers" })
  vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<CR>", { noremap = true, desc = "Prev Buffer" })
  vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<CR>", { noremap = true, desc = "Prev Buffer" })
  vim.keymap.set("n", "<b", "<cmd>BufferLineMovePrev<CR>", { noremap = true, desc = "Shift Buffer" })
  vim.keymap.set("n", "[q", "<cmd>BufferLineCloseLeft<CR>", { noremap = true, desc = "Close Left Buffers" })

  vim.keymap.set("n", "<leader>q", function()
    local current_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_command("BufferLineCyclePrev")
    require("bufdelete").bufdelete(current_buf, false)
  end, { noremap = true, desc = "Close Buffer" })

  vim.keymap.set("n", "<leader>Q", function()
    for _, e in ipairs(require("bufferline").get_elements().elements) do
      vim.schedule(function()
        vim.cmd("bd " .. e.id)
      end)
    end
  end, { noremap = true, silent = true, desc = "Close All" })
end

function M.config()
  local close_buffer_command = function()
    require("bufdelete").bufdelete(0, false)
  end

  require("bufferline").setup({
    options = {
      numbers = "none",
      diagnostics = "nvim_lsp",
      close_command = close_buffer_command,
      separator_style = "slant" or "padded_slant",
      show_tab_indicators = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
      },
      sort_by = "insert_after_current",
    },
  })
end

function M.get_plugin_specs()
  register_keymaps()

  return {
    {
      "famiu/bufdelete.nvim",
    },
    {
      "akinsho/nvim-bufferline.lua",
      config = function()
        require("tabline").config()
      end,
    },
  }
end

return M
