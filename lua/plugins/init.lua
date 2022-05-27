local setup = require("config.setup").setup

local Self = {}

function Self.get_plugins(first_sync)
	return function(use)
		use("wbthomason/packer.nvim")

		use("nvim-lua/plenary.nvim")
		-- Collection of configurations for the built-in LSP client
		use("williamboman/nvim-lsp-installer")

		use({
			"neovim/nvim-lspconfig",
			config = setup("lsp"),
			wants = "nvim-lsp-installer",
			requires = { "williamboman/nvim-lsp-installer", "ray-x/lsp_signature.nvim" },
		})

		use({
			"hrsh7th/nvim-cmp",
			config = setup("cmp"),
			wants = {
				"cmp-buffer",
				"cmp-path",
				"cmp-nvim-lua",
				"cmp-cmdline",
				"cmp-nvim-lsp",
				"cmp_luasnip",
				"LuaSnip",
				"friendly-snippets",
			},
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp",
				"saadparwaiz1/cmp_luasnip",
				{ "L3MON4D3/LuaSnip", wants = "friendly-snippets", config = setup("luasnip") },
				"rafamadriz/friendly-snippets",
			},
		})

		-- autopairs
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		})

		-- vim-endwise
		use("tpope/vim-endwise")

		-- better comments
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		-- better tab names
		use("gcmt/taboo.vim")

		-- multiple cursor
		use({ "mg979/vim-visual-multi", config = setup("visualmulti") })

		-- autoformat
		use({ "mhartington/formatter.nvim", config = setup("formatter") })

		-- grep and replace
		use({ "Danielwsx64/greplace", config = setup("greplace") })

		-- highlight
		use("sheerun/vim-polyglot")

		-- Better surround
		use({ "tpope/vim-surround", event = "InsertEnter" })

		-- Startup screen
		use({ "goolord/alpha-nvim", config = setup("alpha") })

		-- Colorscheme
		use({ "sainnhe/sonokai", config = setup("sonokai") })

		-- Git
		use({
			"TimUntersberger/neogit",
			cmd = "Neogit",
			config = setup("neogit"),
			wants = "plenary.nvim",
		})

		-- Show keymapping hits
		use({ "folke/which-key.nvim", event = "VimEnter", config = setup("whichkey") })

		-- tmux
		use({ "aserowy/tmux.nvim", config = setup("tmux") })
		use({ "danielwsx64/vim-tmux-runner", config = setup("tmuxrunner") })

		-- test
		use({ "vim-test/vim-test", config = setup("vimtest") })

		-- Status line
		use({
			"nvim-lualine/lualine.nvim",
			config = setup("lualine"),
			event = "VimEnter",
			wants = { "nvim-web-devicons", "auto-session" },
			requires = "kyazdani42/nvim-web-devicons",
			after = "sonokai",
		})

		-- File Tree
		use({
			"kyazdani42/nvim-tree.lua",
			wants = "kyazdani42/nvim-web-devicons",
			requires = "kyazdani42/nvim-web-devicons",
			config = setup("nvimtree"),
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			opt = true,
			config = setup("telescope"),
			cmd = { "Telescope" },
			module = "telescope",
			keys = { "<leader>f" },
			wants = {
				"plenary.nvim",
				"popup.nvim",
				"telescope-fzf-native.nvim",
				"telescope-project.nvim",
				"telescope-file-browser.nvim",
				"project.nvim",
			},
			requires = {
				"nvim-lua/popup.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				"nvim-telescope/telescope-project.nvim",
				"nvim-telescope/telescope-file-browser.nvim",
				{ "ahmedkhalf/project.nvim", config = setup("project") },
				{
					"rmagatti/session-lens",
					requires = { "rmagatti/auto-session" },
					config = setup("session_lens"),
				},
			},
		})

		if first_sync then
			print("Restart Neovim required after installation!")
			require("packer").sync()
		end
	end
end

return Self
