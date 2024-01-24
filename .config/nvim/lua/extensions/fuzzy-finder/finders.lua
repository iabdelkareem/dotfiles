local M = {}

M.find_files = function(opts)
  opts = vim.tbl_extend("keep", opt or {}, { show_untracked = true })
  local telescope = require "telescope.builtin"

  local ok = pcall(telescope.git_files, opts)
  if not ok then
    telescope.find_files(opts)
  end
end

-- Custom find buffers function.
M.find_buffers = function()
  local results = {}
  local buffers = vim.api.nvim_list_bufs()

  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buffer) then
      local filename = vim.api.nvim_buf_get_name(buffer)
      table.insert(results, filename)
    end
  end

  vim.ui.select(results, { prompt = "Find buffer:" }, function(selected)
    if selected then
      vim.api.nvim_command("buffer " .. selected)
    end
  end)
end

-- Find dotfiles
M.find_dotfiles = function()
  require("telescope.builtin").git_files {
    prompt_title = "<Dotfiles>",
    cwd = "/mnt/c/Personal/Repositories/dotfiles",
    show_untracked = true,
  }
end

return M
