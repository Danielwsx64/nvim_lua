local Self = {}

local mappings = {
	["?"] = { "<CMD>WhichKey<CR>", "Help" },
	q = { "<CMD>q<CR>", "Quit" },

	-- Explorer commands
	x = {
		name = "File explorer",
		o = { "<CMD>NvimTreeToggle<CR>", "Open file tree" },
		f = { "<CMD>NvimTreeFindFileToggle<CR>", "Open current buffer" },
	},

	-- Find commands
	f = {
		s = { "<cmd>Telescope search_history<cr>", "Search history" },
		h = { "<cmd>Telescope command_history<cr>", "Commands history" },
		f = { "<cmd>Telescope find_files<cr>", "Files" },
		b = { "<cmd>Telescope buffers<cr>", "Buffers" },
		o = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
		g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		x = { "<cmd>Telescope file_browser<cr>", "Browser" },
		r = { "<cmd>Telescope registers<cr>", "Registers" },
		z = { "<cmd>Telescope builtin<cr>", "Sholl all pickers" },
		["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Current Buffer" },
	},

	-- Config commands
	c = {
		name = "Config",
		e = { "<CMD>e $MYVIMRC<CR>", "Edit" },
		r = { "<CMD>so $MYVIMRC<CR>", "Reload" },
	},

	-- Buffer commands
	b = {
		name = "Buffer",
		w = { "<CMD>w<CR>", "Save current" },
		a = { "<CMD>aw<CR>", "Save all" },

		q = { "<CMD>q<CR>", "Quit current" },
		Q = { "<CMD>qa<CR>", "Quit all" },

		e = { "<CMD>e!<CR>", "Reload" },

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

		I = { "<CMD>wincmd x<CR>", "Invert" },
		r = { "<CMD>wincmd J<CR>", "Rotate vertical" },
		R = { "<CMD>wincmd H<CR>", "Rotate horizontal" },

		o = { "<CMD>wincmd o<CR>", "Close others" },
		t = { "<CMD>wincmd T<CR>", "Move to new tab" },

		w = { "<CMD>update!<CR>", "Save current buffer" },
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

		s = { "<CMD>tabs<CR>", "Show all" },

		n = { "<CMD>tabnew<CR>", "New" },
	},

	-- Run (tests) commands
	r = {
		name = "Run (eg: tests)",

		s = { "<CMD>TestFile<CR>", "Test file" },
		n = { "<CMD>TestNearest<CR>", "Test Nearest" },
		l = { "<CMD>TestLast<CR>", "Test last" },
		a = { "<CMD>TestSuite<CR>", "Test all" },
		v = { "<CMD>TestVisit<CR>", "Go to last test file" },
	},

	z = {
		name = "Packer",
		c = { "<CMD>PackerCompile<CR>", "Compile" },
		i = { "<CMD>PackerInstall<CR>", "Install" },
		s = { "<CMD>PackerSync<CR>", "Sync" },
		S = { "<CMD>PackerStatus<CR>", "Status" },
		u = { "<CMD>PackerUpdate<CR>", "Update" },
	},

	g = {
		name = "Git",
		s = { "<CMD>Neogit<CR>", "Status" },
		b = { "<cmd>Telescope git_branches<cr>", "Branches" },
		l = { "<cmd>Telescope git_commits<cr>", "Log" },
	},
}

function Self.setup()
	local whichkey = require("which-key")

	local conf = {
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
		},
	}

	local opts = {
		mode = "n", -- Normal mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	}

	whichkey.setup(conf)
	whichkey.register(mappings, opts)
end

return Self
