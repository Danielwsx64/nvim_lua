local Self = {}

local visual_lead_binds = {
	["?"] = { "<CMD>WhichKey<CR>", "Help" },

	-- Search and Substitute
	s = {
		name = "Search and Substitute",
		s = { "<CMD>DWSBetterReplace<CR>", "Find and replace word near the cursor" },
	},
}

local normal_lead_binds = {
	["?"] = { "<CMD>WhichKey<CR>", "Help" },

	-- help
	h = {
		c = { "<CMD>Cheatsheet<CR>", "Show vim cheatsheets" },
		h = { ":help ", "Open help" },
		m = { "<CMD>help vm-mappings.txt<CR>", "Multi Cursor Keys" },
		o = { "<CMD>vsp ~/.config/nvim/lua/config/octo.lua<CR>", "Octo Config" },
		s = { "<CMD>Telescope luasnip<CR>", "Show buffer Snippets" },
	},

	-- Quit commands
	q = {
		name = "Quit",
		q = { "<CMD>q<CR>", "Current" },
		a = { "<CMD>qa<CR>", "All" },
		f = { "<CMD>q!<CR>", "Force" },
		F = { "<CMD>qa!<CR>", "All force" },
		x = { "<CMD>x<CR>", "Quit saving" },
		X = { "<CMD>xa<CR>", "Quit saving" },
		s = { '<CMD>lua require("util.session").close_session()<CR>', "Session" },
	},

	-- Explorer commands
	e = {
		name = "File explorer",
		f = { "<CMD>NvimTreeFindFileToggle<CR>", "Open current buffer" },
		e = { "<CMD>NvimTreeToggle<CR>", "Open" },
		q = { "<CMD>NvimTreeClose<CR>", "Close" },
	},

	-- Find commands
	f = {
		name = "Find",
		a = { ":Ag ", "Search with ag" },
		s = { "<CMD>Telescope search_history<CR>", "Search history" },
		h = { "<CMD>Telescope command_history<CR>", "Commands history" },
		f = { "<CMD>Telescope find_files<CR>", "Files" },
		b = { "<CMD>Telescope buffers<CR>", "Buffers" },
		o = { "<CMD>Telescope oldfiles<CR>", "Old Files" },
		g = { "<CMD>Telescope live_grep<CR>", "Live Grep" },
		c = { "<CMD>Telescope commands<CR>", "Commands" },
		e = { "<CMD>Telescope file_browser<CR>", "Browser" },
		y = { "<CMD>Telescope neoclip<CR>", "Yanks" },
		z = { "<CMD>Telescope builtin<CR>", "Sholl all pickers" },
		p = { "<CMD>lua require'telescope'.extensions.project.project{}<CR>", "Project" },
		m = { "<CMD>Telescope marks<CR>", "Marks" },
		t = { "<CMD>DWSGoToTest<CR>", "Test file" },
		["/"] = { "<CMD>Telescope current_buffer_fuzzy_find<CR>", "Current Buffer" },
	},

	-- Config commands
	c = {
		name = "Config",
		e = { "<CMD>e $MYVIMRC<CR>", "Edit" },
		r = { "<CMD>so $MYVIMRC<CR>", "Reload" },
		s = { "<CMD>lua require('luasnip.loaders').edit_snippet_files()<CR>", "Edit Snippets" },
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

		f = { "<CMD>res<CR><CMD>vert res<CR>", "Full mode" },
		e = { "<CMD>wincmd =<CR>", "Exit full" },

		h = { "<CMD>wincmd h<CR>", "Go left" },
		l = { "<CMD>wincmd l<CR>", "Go right" },
		k = { "<CMD>wincmd k<CR>", "Go top" },
		j = { "<CMD>wincmd j<CR>", "Go down" },

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
		d = { "<CMD>DeleteSession<CR>", "Delete" },
		s = { "<CMD>SaveSession<CR>", "Save" },
	},

	-- Search and Substitute
	s = {
		name = "Search and Substitute",
		n = { "<CMD>DWSBetterSearch<CR>", "Search word under cursor" },
		s = { "<CMD>DWSBetterReplace<CR>", "Find and replace word near the cursor" },
		f = { "<CMD>Telescope grep_string<CR>", "Search word under cursor in workspace" },
		h = { "<CMD>Telescope search_history<CR>", "Show the search history" },
	},

	-- Tabs commands
	t = {
		name = "Tabs",
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
	},

	-- Run (tests) commands
	r = {
		name = "Run (eg: tests)",

		s = { "<CMD>TestFile<CR>", "Test file" },
		n = { "<CMD>TestNearest<CR>", "Test Nearest" },
		l = { "<CMD>TestLast<CR>", "Test last" },
		a = { "<CMD>TestSuite<CR>", "Test all" },
		-- v = { "<CMD>TestVisit<CR>", "Go to last test file" },
		v = { "<CMD>:VtrAttachToPane<CR>", "Reattach tmux pane" },
	},

	z = {
		name = "Packer",
		c = { "<CMD>PackerCompile<CR>", "Compile" },
		i = { "<CMD>PackerInstall<CR>", "Install" },
		s = { "<CMD>PackerSync<CR>", "Sync" },
		S = { "<CMD>PackerStatus<CR>", "Status" },
		u = { "<CMD>PackerUpdate<CR>", "Update" },
	},

	-- Git commands
	g = {
		name = "Git",
		n = { "<CMD>VGit hunk_down<CR>", "Next hunk" },
		m = { "<CMD>VGit hunk_up<CR>", "Previous hunk" },

		d = { "<CMD>VGit buffer_diff_preview<CR>", "Buffer diff" },
		h = { "<CMD>VGit buffer_history_preview<CR>", "Buffer history" },
		g = { "<CMD>VGit toggle_live_gutter<CR>", "Live gutter" },

		b = { "<CMD>VGit buffer_blame_preview<CR>", "Cursor blame" },
		B = { "<CMD>VGit buffer_gutter_blame_preview<CR>", "Buffer blame" },

		s = { "<CMD>Neogit<CR>", "Status" },
		l = { "<CMD>Telescope git_commits<CR>", "Log" },
		L = { "<CMD>VGit project_logs_preview<CR>", "VGit log" },
		-- b = { "<CMD>Telescope git_branches<CR>", "Branches" },
	},
	["<ESC>"] = { "<CMD>nohlsearch<CR>", "Cancel search" },
}

local custom_normal_binds = {
	S = { ":let @/= '\\<' . expand('<cword>') . '\\>'<CR>:%s//", "Substitute word under cursor" },
}

local custom_visual_binds = {
	-- s = { "*<c-v>:<c-u>%s//", "Substitute selected text in file" },
}

function Self.register()
	local whichkey = require("which-key")

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
