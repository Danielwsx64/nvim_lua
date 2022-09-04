local api = vim.api
local g = vim.g

-- This file remaps some default keys.
-- To see leader mappins look at  lua/config/whichkey.lua
local function map(mode, lhs, rhs, desc)
	api.nvim_set_keymap(mode, lhs, rhs, {
		noremap = false,
		silent = true,
		desc = desc,
	})
end

local function noremap(mode, lhs, rhs, desc)
	api.nvim_set_keymap(mode, lhs, rhs, {
		noremap = true,
		silent = true,
		desc = desc,
	})
end

local function xnoremap(mode, lhs, rhs, desc)
	api.nvim_set_keymap(mode, lhs, rhs, {
		noremap = true,
		expr = true,
		silent = true,
		desc = desc,
	})
end
-- nvim_set_keymap({mode}, {lhs}, {rhs}, {*opts})             *nvim_set_keymap()*

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

-- Better escape using jk in insert and terminal mode
noremap("i", "jk", "<ESC>", "Scape, same as <ESC>")
-- noremap("t", "jk", "<C-\\><C-n>", "")

-- Center search results
noremap("n", "n", "nzz", "Go to next found")
noremap("n", "N", "Nzz", "Go to previous found")

-- Visual line wraps
xnoremap("n", "k", "v:count == 0 ? 'gk' : 'k'", "Move up")
xnoremap("n", "j", "v:count == 0 ? 'gj' : 'j'", "Move down")

-- Better indent
noremap("v", "<", "<gv", "Indent and reselect")
noremap("v", ">", ">gv", "Remove indent and reselect")

-- Move selected line / block of text in visual mode
noremap("x", "<Up>", ":move '<-2<CR>gv-gv", "Move selected up")
noremap("x", "<Down>", ":move '>+1<CR>gv-gv", "Move seleced down")

-- better search
map("n", "*", "<CMD>DWSBetterSearch<CR>", "Search foward word under cursor")
map("v", "*", "<CMD>DWSBetterSearch<CR>", "Search foward selection")

-- Avoid starting macro recording by chance
noremap("n", "Q", "q", "Record macro")
noremap("n", "q", "<Nop>", "Nothing")

-- Resizing panes
-- noremap("n", "<Right>", ":vertical resize +1<CR>", "Resize window left")
-- noremap("n", "<Left>", ":vertical resize -1<CR>", "Resize window right")
-- noremap("n", "<Up>", ":resize -1<CR>", "Resize window up")
-- noremap("n", "<Down>", ":resize +1<CR>", "Resize window down")

-- >>> Maybe it can be useful
--
-- Paste over currently selected text without yanking it
-- noremap("v", "p", '"_dP', default_opts)
--
-- Switch buffer
-- noremap("n", "<S-h>", ":bprevious<CR>", default_opts)
-- noremap("n", "<S-l>", ":bnext<CR>", default_opts)
