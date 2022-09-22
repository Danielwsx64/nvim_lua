local vim = vim or {}

vim.cmd("set termguicolors")

vim.opt.termguicolors = true -- Enable colors in terminal
vim.opt.hlsearch = true --Set highlight on search
vim.opt.number = true --Make line numbers default
vim.opt.relativenumber = true --Make relative number default

vim.opt.wrap = false -- Wrap lines
vim.opt.breakindent = false --Enable break indent
vim.opt.undofile = false --Save undo history
vim.opt.ignorecase = true --Case insensitive searching unless /C or capital in search
vim.opt.smartcase = true -- Smart case

vim.opt.clipboard:append({ "unnamedplus" }) -- Access system clipboard
vim.opt.timeoutlen = 500 -- Time in milliseconds to wait for a mapped sequence to complete.
vim.opt.autoread = true -- always reload files
vim.opt.colorcolumn = "80" -- see mark in colum 80

-- ident config
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

vim.opt.mouse = "ar" --Enable mouse mode
-- vim.opt.updatetime = 250 --Decrease update time
-- vim.opt.signcolumn = "yes" -- Always show sign column

vim.opt.inccommand = "split"

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	command = "silent! lua vim.highlight.on_yank()",
})

vim.api.nvim_set_hl(0, "CurSearch", { link = "IncSearch" })
