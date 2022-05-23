local api = vim.api
local g = vim.g

-- This file remaps some default keys.
-- To see leader mappins look at  lua/config/whichkey.lua

local function map(mode, lhs, rhs, desc)
	api.nvim_set_keymap(mode, lhs, rhs, {
		noremap = true,
		silent = true,
		desc = desc,
	})
end

local function xmap(mode, lhs, rhs, desc)
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
map("i", "jk", "<ESC>", "Scape, same as <ESC>")
-- map("t", "jk", "<C-\\><C-n>", "")

-- Center search results
map("n", "n", "nzz", "Go to next found")
map("n", "N", "Nzz", "Go to previous found")

-- Visual line wraps
xmap("n", "k", "v:count == 0 ? 'gk' : 'k'", "Move up")
xmap("n", "j", "v:count == 0 ? 'gj' : 'j'", "Move down")

-- Better indent
map("v", "<", "<gv", "Indent and reselect")
map("v", ">", ">gv", "Remove indent and reselect")

-- Cancel search highlighting with //
map("n", "//", ":nohlsearch<Bar>:echo<CR>", "Cancel search")

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", "Move selected up")
map("x", "J", ":move '>+1<CR>gv-gv", "Move seleced down")

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>", "Resize window left")
map("n", "<Right>", ":vertical resize -1<CR>", "Resize window right")
map("n", "<Up>", ":resize -1<CR>", "Resize window up")
map("n", "<Down>", ":resize +1<CR>", "Resize window down")

-- >>> Maybe it can be useful
--
-- Paste over currently selected text without yanking it
-- map("v", "p", '"_dP', default_opts)
--
-- Switch buffer
-- map("n", "<S-h>", ":bprevious<CR>", default_opts)
-- map("n", "<S-l>", ":bnext<CR>", default_opts)
