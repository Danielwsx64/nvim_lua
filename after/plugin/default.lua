local opt = vim.opt
local cmd = vim.cmd

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search

opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default

opt.breakindent = true --Enable break indent
opt.undofile = false --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.clipboard = "unnamedplus" -- Access system clipboard

-- opt.signcolumn = "yes" -- Always show sign column
-- opt.mouse = "a" --Enable mouse mode
-- opt.updatetime = 250 --Decrease update time

-- Highlight on yank
cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])
