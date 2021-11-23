local M = {}

local function config()
  vim.cmd("colorscheme darkplus")
  -- UFO
  -- hi default UfoFoldedFg guifg=Normal.foreground
  -- hi default UfoFoldedBg guibg=Folded.background
  vim.api.nvim_set_hl(0, "UfoPreviewSbar", { link = "PmenuSbar" })
  vim.api.nvim_set_hl(0, "UfoPreviewThumb", { link = "PmenuThumb" })
  vim.api.nvim_set_hl(0, "UfoPreviewWinBar", { link = "UfoFoldedBg" })
  vim.api.nvim_set_hl(0, "UfoPreviewCursorLine", { link = "Visual" })
  vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { link = "Comment" })
  vim.api.nvim_set_hl(0, "UfoCursorFoldedLine", { link = "CursorLine" })

  -- Leap
  vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#6C7A96" })
  vim.api.nvim_set_hl(0, "LeapMatch", {
    fg = "white",
    bold = true,
    nocombine = true,
  })

  -- Dap
  vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#b92e11" })
  vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#182f8a" })
  vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#c3bb20" })
  vim.api.nvim_set_hl(0, "DapStopped", { bg = "#edd731", fg = "#000000" })
  vim.api.nvim_set_hl(0, "DapStoppedSign", { fg = "#e7e87a" })

  -- Illuminate
  vim.api.nvim_set_hl(0, "illuminatedCurWord", { underline = true })
  vim.api.nvim_set_hl(0, "illuminatedWordText", { underline = true })
  vim.api.nvim_set_hl(0, "illuminatedWordRead", { underline = true })
  vim.api.nvim_set_hl(0, "illuminatedWordWrite", { underline = true })

  -- Diff
  vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#4B5632" })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = "#4B1818" })
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#6F1313" })
  vim.api.nvim_set_hl(0, "DiffText", { bg = "#6F1313" })
end

function M.get_plugin_specs()
  return {
    {
      "LunarVim/darkplus.nvim",
      config = config,
      priority = 1001,
    },
  }
end

return M
