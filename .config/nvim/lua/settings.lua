local api = vim.api
local g = vim.g
local opt = vim.opt

local default_indent = 2

opt.termguicolors = true
opt.number = true
opt.updatetime = 250
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.relativenumber = true

api.nvim_win_set_option(0, "number", true)
opt.tabstop = default_indent
opt.softtabstop = default_indent
opt.shiftwidth = default_indent
opt.expandtab = true
opt.smartindent = true
--

opt.linebreak = true
opt.breakindent = true
opt.cursorline = true
opt.showbreak = "> "
opt.signcolumn = "yes:1"
opt.clipboard = "unnamedplus"
--opt.lazyredraw = true
--opt.showmatch = true
opt.confirm = true
opt.visualbell = true
--opt.mouse = 'a'
--opt.cmdheight = 2
opt.splitbelow = true
opt.splitright = true
opt.autowrite = true
opt.timeoutlen = 300

-- opt.updatetime = 300
--opt.grepprg = 'rg --no-heading --vimgrep --smart-case'
--opt.hidden = true
opt.completeopt = "menu,menuone,preview,noselect"

local yank_highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = false })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_highlight_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight text after yank",
})

-- Search
opt.path:remove("/usr/include")
opt.path:append("**")
opt.wildignorecase = true
opt.wildignore:append("**/node_modules/*")
opt.wildignore:append("**/.git/*")

-- Better Netrw
g.netrw_banner = 0                                                                  -- Hide banner
g.netrw_browse_split = 4                                                            -- Open in previous window
g.netrw_altv = 1                                                                    -- Open with right splitting
g.netrw_liststyle = 3                                                               -- Tree-style view
g.netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) .. [[,\(^\|\s\s\)\zs\.\S\+]] -- use .gitignore
vim.o.autoread = true

vim.api.nvim_set_keymap("n", "<C-W>c", "<cmd>lua require('bufdelete').bufdelete(0)<CR><cmd>close<CR>", { noremap = true, silent = true, desc = "Close Window" })

vim.opt_global.formatoptions:remove({ "c", "r", "o" })
vim.opt.formatoptions:remove({ "c", "r", "o" })

vim.cmd([[
nnoremap <silent> ]<Space> :<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "'[-1"<CR>
nnoremap <silent> [<Space> :<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "']+1"<CR>
]])

vim.keymap.set("n", "yp", function()
  local filename = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg("+", filename)
  -- vim.api.
end, { desc = "Yank file path" })
