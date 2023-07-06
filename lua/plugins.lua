local Self = {}

Self.plugins_list = {
	"wbthomason/packer.nvim",

	-- Othe plugins deps
	"nvim-lua/plenary.nvim",

	-- Icons
	"kyazdani42/nvim-web-devicons",

	-- LSP - Collection of configurations for the built-in LSP client
	"ray-x/lsp_signature.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{ "neovim/nvim-lspconfig", "lsp" },

	-- popup (required for other plugins -- See if is yet needed)
	{ "nvim-lua/popup.nvim" },

	-- Treesitter
	"nvim-treesitter/playground",
	"p00f/nvim-ts-rainbow",
	"nvim-treesitter/nvim-treesitter-refactor",
	"andymass/vim-matchup",
	{ "nvim-treesitter/nvim-treesitter", "treesitter", run = ":TSUpdate" },

	-- HTTP request
	{ "rest-nvim/rest.nvim", "rest" },

	-- Zen Mode (fullscreen)
	{ "folke/zen-mode.nvim", "zenmode" },

	-- Better Color
	{ "uga-rosa/ccc.nvim", "ccc" },

	-- Better notification
	{ "rcarriga/nvim-notify", "notify" },

	-- snippets
	"rafamadriz/friendly-snippets",
	"benfowler/telescope-luasnip.nvim",
	{ "L3MON4D3/LuaSnip", "luasnip" },

	-- Code completation
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"saadparwaiz1/cmp_luasnip",
	{ "hrsh7th/nvim-cmp", "cmp" },

	-- autopairs
	{ "windwp/nvim-autopairs", "autopairs" },

	-- Better comments
	{ "numToStr/Comment.nvim", "comment" },

	-- Better fold
	"kevinhwang91/promise-async",
	{ "kevinhwang91/nvim-ufo", "ufo" },

	-- multiple cursor
	{ "mg979/vim-visual-multi", "visualmulti" },

	-- autoformat
	{ "mhartington/formatter.nvim", "formatter" },

	-- Better grep and replace
	{ "Danielwsx64/greplace", "greplace" },

	-- Better surround
	{ "kylechui/nvim-surround", "surround" },

	-- Startup screen
	{ "goolord/alpha-nvim", "alpha" },

	-- Colorscheme and Themes
	-- { "ThemerCorp/themer.lua", "themer" },
	{ "Danielwsx64/themer.lua", "themer" },

	-- Git
	{ "sindrets/diffview.nvim", "diffview" },
	{ "NeogitOrg/neogit", "neogit" },
	{ "lewis6991/gitsigns.nvim", "gitsigns" },
	{ "ruifm/gitlinker.nvim", "gitlinker" },

	-- Show keymapping hits
	{ "folke/which-key.nvim", "whichkey" },

	-- tmux
	{ "aserowy/tmux.nvim", "tmux" },

	-- test
	{ "vim-test/vim-test", "vimtest" },

	-- Status line
	"nvim-lua/lsp-status.nvim",
	{ "nvim-lualine/lualine.nvim", "lualine" },

	-- File Tree
	{ "kyazdani42/nvim-tree.lua", "nvimtree" },

	-- My own plugin
	{ "~/workspace/danielws.vim/", "danielws" },

	-- Configure sessions
	-- Esta com uma erro no start, acabo não usando essa feature
	-- { "rmagatti/auto-session", "session" },
	-- { "rmagatti/session-lens" },

	-- Yank/Clipboard manager (needs telescope or fzf)
	{ "AckslD/nvim-neoclip.lua", "neoclip" },

	-- Project
	-- { "ahmedkhalf/project.nvim", "project" },

	-- Telescope
	-- "nvim-telescope/telescope-project.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	{ "nvim-telescope/telescope.nvim", "telescope" },

	-- Depends on telescope
	-- Show symbols (emojis)
	{ "nvim-telescope/telescope-symbols.nvim" },

	-- Show cheatsheet for vim
	{ "sudormrfbin/cheatsheet.nvim" },
}

-- DEPRECATED START
-- Integration with github cli
-- { "pwntester/octo.nvim", "octo" },
-- Integration with github cli
-- { "nvim-telescope/telescope-github.nvim" },
-- Terminal
-- "tknightz/telescope-termfinder.nvim",
-- { "akinsho/toggleterm.nvim", "toggleterm" },
-- OrgMode
-- { "nvim-orgmode/orgmode", "orgmode" },
-- { "nvim-neorg/neorg", "neorg", run = ":Neorg sync-parsers" },
-- DEPRECATED END

return Self
