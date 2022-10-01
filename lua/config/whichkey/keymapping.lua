local Self = {}

local visual_lead_binds = {
	["?"] = { "<CMD>WhichKey<CR>", "Help" },

	-- Search and Substitute
	s = {
		name = "Search and Substitute",
		s = { "<CMD>Danielws better_replace<CR>", "Find and replace word near the cursor" },
	},
	f = {
		name = "Format",

		p = { "<CMD>Danielws elixir pipelize<CR>", "Elixir turns into pipe" },
	},
}

local normal_lead_binds = {
	["?"] = { "<CMD>WhichKey<CR>", "Help" },

	-- help
	h = {
		c = { "<CMD>Cheatsheet<CR>", "Show vim cheatsheets" },
		h = { "<CMD>Telescope help_tags<CR>", "Open help" },
		m = { "<CMD>help vm-mappings.txt<CR>", "Multi Cursor Keys" },
		o = { "<CMD>vsp ~/.config/nvim/lua/config/octo.lua<CR>", "Octo Config" },
		s = { "<CMD>Telescope luasnip<CR>", "Show buffer Snippets" },
	},

	-- Quit commands
	q = {
		name = "Quit",
		q = { "<CMD>q<CR>", "Quit current window" },

		-- a = { "<CMD>lua require('util.exit').quit_all()<CR>", "Quit all" },
		a = { "<CMD>Danielws quit_all<CR>", "Quit all" },
		f = { "<CMD>q!<CR>", "Force" },
		F = { "<CMD>qa!<CR>", "All force" },
		x = { "<CMD>x<CR>", "Quit saving" },
		X = { "<CMD>xa<CR>", "Quit saving" },
		s = { "<CMD>lua require('danielws.exit').close_session()<CR>", "Session" },
	},

	-- Explorer commands
	e = {
		name = "File explorer",
		f = { "<CMD>NvimTreeFindFile<CR>", "Open current buffer" },
		e = { "<CMD>NvimTreeToggle<CR>", "Open" },
		q = { "<CMD>NvimTreeClose<CR>", "Close" },
	},

	-- Telescope commands
	["<space>"] = {
		name = "Telescope finders",
		a = { ":Ag ", "Search with ag" },
		S = { "<CMD>Telescope search_history<CR>", "Search history" },
		s = { "<CMD>Telescope current_buffer_fuzzy_find<CR>", "Current Buffer" },
		h = { "<CMD>Telescope command_history<CR>", "Commands history" },
		f = { "<CMD>Telescope find_files<CR>", "Files" },
		b = { "<CMD>Telescope buffers<CR>", "Buffers" },
		o = { "<CMD>Telescope oldfiles<CR>", "Old Files" },
		g = { "<CMD>Telescope live_grep<CR>", "Live Grep" },
		c = { "<CMD>Telescope commands<CR>", "Commands" },
		e = { "<CMD>Telescope symbols<CR>", "Emoji/EmotIcons" },
		E = { "<CMD>Telescope file_browser<CR>", "Browser" },
		y = { "<CMD>Telescope neoclip<CR>", "Yanks" },
		z = { "<CMD>Telescope builtin<CR>", "Sholl all pickers" },
		p = { "<CMD>lua require'telescope'.extensions.project.project{}<CR>", "Project" },
		m = { "<CMD>Telescope keymaps<CR>", "Show keymaps" },
		M = { "<CMD>Telescope marks<CR>", "Marks" },
		n = { "<CMD>Telescope notify<CR>", "Notifications" },
	},

	-- Find or Formatters
	f = {
		name = "Find or Formatters",
		t = { "<CMD>Danielws elixir go_to_test<CR>", "Test file or back" },
	},

	-- LSP commands
	l = {
		name = "LSP commands",
		g = { "<CMD>Telescope lsp_references<CR>", "References" },
		s = { "<CMD>Telescope lsp_document_symbols<CR>", "List symbols" },
	},

	-- Config commands
	c = {
		name = "Config",
		e = { "<CMD>e $MYVIMRC<CR>", "Edit" },
		r = { "<CMD>so $MYVIMRC<CR>", "Reload" },
		s = { "<CMD>lua require('luasnip.loaders').edit_snippet_files()<CR>", "Edit Snippets" },
		c = { "<CMD>lua require('config.colorscheme').picker()<CR>", "Switch colorscheme" },
	},

	-- Buffer commands
	b = {
		name = "Buffer",
		w = { "<CMD>w<CR>", "Save current" },
		a = { "<CMD>wa<CR>", "Save all" },

		q = { "<CMD>q<CR>", "Quit current" },
		Q = { "<CMD>qa<CR>", "Quit all" },

		r = { "<CMD>e!<CR>", "Reload" },
		f = { "<CMD>Format<CR>", "Format" },

		l = { "<c-^>", "Go last" },

		d = { "<CMD>bd!<CR>", "Delete current" },
		D = { "<CMD>%bd|e#|bd#<CR>", "Delete all" },
	},

	-- Windows commands
	w = {
		name = "Windows",

		f = { "<CMD>res<CR><CMD>vert res<CR>", "Windows Full mode" },
		e = { "<CMD>wincmd =<CR>", "All windows same size" },
		E = { "<CMD>wincmd = | Danielws tmux resize_vim_pane 50<CR>", "Equal tmux vim pane" },
		z = { "<CMD>Danielws tmux resize_vim_pane z<CR>", "Full screen vim Tmux pane" },
		c = { "<CMD>Danielws tmux resize_vim_pane 75<CR>", "Resize tmux vim pane" },

		h = { "<CMD>lua require('tmux.navigation.navigate').to('h')<CR>", "Go left" },
		l = { "<CMD>lua require('tmux.navigation.navigate').to('l')<CR>", "Go right" },
		k = { "<CMD>lua require('tmux.navigation.navigate').to('k')<CR>", "Go top" },
		j = { "<CMD>lua require('tmux.navigation.navigate').to('j')<CR>", "Go down" },

		n = { "<CMD>vnew<CR>", "New vertical" },
		m = { "<CMD>new<CR>", "New horizontal" },

		v = { "<CMD>vsplit<CR>", "Split vertical" },
		s = { "<CMD>split<CR>", "Split horizontal" },

		i = { "<CMD>wincmd x<CR>", "Invert" },
		r = { "<CMD>wincmd J<CR>", "Rotate vertical" },
		R = { "<CMD>wincmd H<CR>", "Rotate horizontal" },

		o = { "<CMD>wincmd o<CR>", "Close others" },
		t = { "<CMD>wincmd T<CR>", "Move to new tab" },

		w = { "<CMD>update<CR>", "Save current buffer" },
		a = { "<CMD>wa<CR>", "Save all buffers" },
		q = { "<CMD>q<CR>", "Quit current" },
	},

	-- Session commands
	S = {
		name = "Sessions",
		l = { "<CMD>Telescope session-lens search_session<CR>", "List" },
		r = { "<CMD>RestoreSession<CR>", "Restore" },
		d = { "<CMD>DeleteSession<CR>", "Delete" },
		s = { "<CMD>SaveSession<CR>", "Save" },
	},

	-- Search, Substitute
	s = {
		name = "Search and Substitute",
		n = { "<CMD>Danielws better_search<CR>", "Search word under cursor" },
		s = { "<CMD>Danielws better_replace<CR>", "Find and replace word near the cursor" },
		f = { "<CMD>Telescope grep_string<CR>", "Search word under cursor in workspace" },
		h = { "<CMD>Telescope search_history<CR>", "Show the search history" },
	},

	-- Tabs and Tmux moves commands
	t = {
		name = "Tabs and Tmux moves",
		b = { "<CMD>tabm -<CR>", "Move back" },
		f = { "<CMD>tabm +<CR>", "Move forward" },

		h = { "<CMD>tabp<CR>", "Go left" },
		l = { "<CMD>tabn<CR>", "Go right" },

		j = { "<CMD>tabr<CR>", "Go first" },
		k = { "<CMD>tabl<CR>", "Go last" },

		o = { "<CMD>tabo<CR>", "Close othes" },
		q = { "<CMD>tabc<CR>", "Close" },

		s = { "<CMD>tab split<CR>", "Split current buffer in a new tab" },
		S = { "<CMD>tabs<CR>", "Show all" },

		n = { "<CMD>tabnew<CR>", "New" },

		t = {
			name = "Tmux moves",
			n = { "<CMD>Danielws tmux new_window<CR>", "Create a new tmux window" },
			l = { "<CMD>Danielws tmux next_window<CR>", "Move to next window" },
			h = { "<CMD>Danielws tmux previous_window<CR>", "Move to previous window" },
			b = { "<CMD>Danielws tmux last_window<CR>", "Move to last window" },
			v = { "<CMD>Danielws tmux window_split h<CR>", "Split window v" },
			s = { "<CMD>Danielws tmux window_split v<CR>", "Split window" },
		},
	},

	-- Run tests and shell commands
	r = {
		name = "Run tests and shell",

		s = { "<CMD>TestFile<CR>", "Test file" },
		n = { "<CMD>TestNearest<CR>", "Test Nearest" },
		l = { "<CMD>TestLast<CR>", "Test last" },
		a = { "<CMD>TestSuite<CR>", "Test all" },
		V = { "<CMD>TestVisit<CR>", "Go to last test file" },

		c = { "<CMD>lua require('config.vimtest').change()<CR>", "Change test strategy" },

		A = { "<CMD>ToggleTermToggleAll<CR>", "Open all terminal" },
		o = { "<CMD>ToggleTerm<CR>", "Open terminal" },
		L = { "<CMD>Telescope termfinder find<CR>", "List terminals" },

		h = { "<CMD>Telescope danielws shell_history<CR>", "Run hitory on tmux" },
		v = { "<CMD>:VtrAttachToPane<CR>", "Reattach tmux pane" },
	},

	z = {
		name = "Packer",
		-- c = { "<CMD>PackerCompile<CR>", "Compile" },
		-- i = { "<CMD>PackerInstall<CR>", "Install" },
		-- u = { "<CMD>PackerUpdate<CR>", "Update" },
		s = { "<CMD>PackerSync<CR>", "Sync" },
		S = { "<CMD>PackerStatus<CR>", "Status" },
		r = { "<CMD>lua require('bootloader').sync_plugins()<CR>", "Reload and Sync" },
	},

	-- Git commands
	g = {
		name = "Git",
		n = { "<CMD>lua require('gitsigns').next_hunk()<CR>", "Next hunk" },
		p = { "<CMD>lua require('gitsigns').prev_hunk()<CR>", "Previous hunk" },
		d = { "<CMD>lua require('gitsigns').preview_hunk()<CR>", "Diff hunk" },
		D = { "<CMD>lua require('gitsigns').diffthis()<CR>", "Diff buffer" },
		b = { "<CMD>lua require('gitsigns').blame_line{full=true}<CR>", "Blame line" },
		B = { "<CMD>lua require('gitsigns').toggle_current_line_blame()<CR>", "Buffer blame" },
		h = { "<CMD>DiffviewFileHistory %<CR>", "Buffer history" },
		L = { "<CMD>DiffviewFileHistory<CR>", "DiffView log" },

		o = { "<CMD>Neogit<CR>", "Open NeoGit" },
		s = { "<CMD>Telescope git_status<CR>", "Status" },
		l = { "<CMD>Telescope git_commits<CR>", "Log" },
		c = { "<CMD>Telescope danielws co_authors<CR>", "Apply co-authors" },
	},
	["<ESC>"] = { "<CMD>nohlsearch<CR>", "Cancel search" },
}

local custom_normal_binds = {
	S = { ":let @/= '\\<' . expand('<cword>') . '\\>'<CR>:%s//", "Substitute word under cursor" },
}

local custom_visual_binds = {
	-- s = { "*<c-v>:<c-u>%s//", "Substitute selected text in file" },
}

local function noremap(mod, lhs, rhs, desc)
	vim.keymap.set(mod, lhs, rhs, { desc = desc, silent = true })
end

local function xnoremap(mod, lhs, rhs, desc)
	vim.keymap.set(mod, lhs, rhs, { desc = desc, silent = true, expr = true })
end

local function map(mod, lhs, rhs, desc)
	vim.keymap.set(mod, lhs, rhs, { desc = desc, silent = true, remap = true })
end

function Self.register()
	local whichkey = require("which-key")
	local luasnip = require("luasnip")

	-- Remap leader and local leader to <Space>
	-- vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
	noremap("", "<Space>", "<Nop>", "Define <space> as leader")
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

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
	map("n", "*", "<CMD>Danielws better_search<CR>", "Search foward word under cursor")
	map("v", "*", "<CMD>Danielws better_search<CR>", "Search foward selection")

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

	-- change Snippets choice
	noremap({ "s", "i" }, "<c-n>", function()
		if luasnip.choice_active() then
			luasnip.change_choice(1)
		end
	end, "LuaSnip next choice")

	noremap({ "s", "i" }, "<c-p>", function()
		if luasnip.choice_active() then
			luasnip.change_choice(-1)
		end
	end, "LuaSnip previous choice")

	whichkey.register(normal_lead_binds, {
		mode = "n", -- Normal mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	})

	whichkey.register(visual_lead_binds, {
		mode = "v", -- Normal mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	})

	whichkey.register(custom_normal_binds, {
		mode = "n", -- Normal mode
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	})

	whichkey.register(custom_visual_binds, {
		mode = "v", -- Visual mode
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	})
end

return Self
