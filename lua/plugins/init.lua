local setup = require("config.setup").setup

local Self = {}

function Self.get_plugins(first_sync)
	return function(use)
		use("wbthomason/packer.nvim")

		-- Collection of configurations for the built-in LSP client
		use("williamboman/nvim-lsp-installer")

		use({
			"neovim/nvim-lspconfig",
			config = setup("lsp"),
			requires = { "williamboman/nvim-lsp-installer", "ray-x/lsp_signature.nvim" },
		})

		use({
			"hrsh7th/nvim-cmp",
			config = setup("cmp"),
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

		-- better comments
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

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
		use({ "TimUntersberger/neogit", cmd = "Neogit", config = setup("neogit"), requires = "nvim-lua/plenary.nvim" })

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
			wants = "nvim-web-devicons",
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
				"telescope-file-browser.nvim",
			},
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				"nvim-telescope/telescope-file-browser.nvim",
			},
		})

		-- Some usefull plugins to use
		-- https://github.com/Shatur/neovim-session-manager

		if first_sync then
			print("Restart Neovim required after installation!")
			require("packer").sync()
		end
	end
end

return Self
