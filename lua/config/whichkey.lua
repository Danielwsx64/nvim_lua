local Self = {}

local mappings = {
	["?"] = { "<CMD>WhichKey<CR>", "Help" },
	q = { "<CMD>q<CR>", "Quit" },
	x = { "<CMD>NvimTreeToggle<CR>", "Files tree" },

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
