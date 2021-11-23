local M = {}

function M.get_context()
  return require("nvim-navic").get_location()
end

function M.is_available()
  local ok, module = pcall(require, "nvim-navic")
  if ok then
    return module.is_available()
  end

  return false
end

local function on_attach_callback(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

function M.get_plugin_specs()
  return {
    {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig",
      init = function()
        vim.api.nvim_create_autocmd("LspAttach", { callback = on_attach_callback })
      end,
      config = function()
        vim.g.navic_silence = true
        require("nvim-navic").setup({
          highlight = true,
        })
      end,
    },
  }
end

return M
