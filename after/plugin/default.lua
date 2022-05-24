local opt = vim.opt
local cmd = vim.cmd
local nvim_create_augroup = vim.api.nvim_create_augroup
local nvim_create_autocmd = vim.api.nvim_create_autocmd

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default

opt.wrap = false -- Wrap lines
opt.breakindent = false --Enable break indent
opt.undofile = false --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case

opt.clipboard:append({ "unnamedplus" }) -- Access system clipboard
opt.timeoutlen = 500 -- Time in milliseconds to wait for a mapped sequence to complete.
opt.autoread = true -- always reload files
opt.colorcolumn = "80" -- see mark in colum 80

-- ident config
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

-- opt.signcolumn = "yes" -- Always show sign column
-- opt.mouse = "a" --Enable mouse mode
-- opt.updatetime = 250 --Decrease update time

-- Highlight on yank
nvim_create_autocmd("TextYankPost", {
	group = nvim_create_augroup("YankHighlight", { clear = true }),
	command = "silent! lua vim.highlight.on_yank()",
})

-- prevent typo in commons commands
cmd("command W w")
cmd("command Wa wa")
cmd("command Q q")
cmd("command Qa qa")
