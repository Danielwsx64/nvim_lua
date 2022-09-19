local setup = require("config.setup").setup

local Self = {}

function Self.get_plugins(first_sync)
	return function(use)
		-- parece interessante um plugin de find replace
		-- "nvim-pack/nvim-spectre"

		use("wbthomason/packer.nvim")

		-- Database DBML sintax highlight and file type
		use("jidn/vim-dbml")

		-- Othe plugins deps
		use("nvim-lua/plenary.nvim")

		-- Collection of configurations for the built-in LSP client
		use("williamboman/nvim-lsp-installer")

		-- popup
		use("nvim-lua/popup.nvim")

		-- Treesitter
		use({ "nvim-treesitter/nvim-treesitter", config = setup("treesitter"), run = "TSUpdate" })
		use("nvim-treesitter/playground")
		use("p00f/nvim-ts-rainbow")
		use("nvim-treesitter/nvim-treesitter-refactor")

		-- Better notification
		use({ "rcarriga/nvim-notify", config = setup("notify") })

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

		-- Telescope integration with LuaSnip snippets
		use({ "benfowler/telescope-luasnip.nvim", wants = { "LuaSnip", "telescope.vim" } })

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

		-- better fold
		use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async", config = setup("ufo") })

		-- better tab names
		use("gcmt/taboo.vim")

		-- multiple cursor
		use({ "mg979/vim-visual-multi", config = setup("visualmulti") })

		-- autoformat
		use({ "mhartington/formatter.nvim", config = setup("formatter") })

		-- grep and replace
		use({ "Danielwsx64/greplace", config = setup("greplace") })

		-- highlight
		-- use("sheerun/vim-polyglot")

		-- Better surround
		use({ "tpope/vim-surround", event = "InsertEnter" })

		-- Startup screen
		use({ "goolord/alpha-nvim", config = setup("alpha") })

		-- Colorscheme
		use("sainnhe/sonokai")
		use("tanvirtin/monokai.nvim")
		use("rafamadriz/neon")
		use("mhartington/oceanic-next")
		use("ray-x/starry.nvim")
		use("ful1e5/onedark.nvim")
		use({ "marko-cerovac/material.nvim", config = setup("colorscheme") })

		-- Git
		use({ "sindrets/diffview.nvim", wants = { "plenary.vim" } })
		use({
			"TimUntersberger/neogit",
			cmd = "Neogit",
			config = setup("neogit"),
			wants = { "plenary.nvim", "diffview.nvim" },
		})
		use({ "tanvirtin/vgit.nvim", wants = { "plenary.nvim" }, config = setup("vgit") })

		-- Integration with github cli
		use({
			"pwntester/octo.nvim",
			wants = { "plenary.nvim", "telescope.nvim", "nvim-web-devicons" },
			config = setup("octo"),
		})

		-- Integration with github cli
		use({ "nvim-telescope/telescope-github.nvim", wants = { "telescope.vim" } })

		-- Show keymapping hits
		use({ "folke/which-key.nvim", event = "VimEnter", config = setup("whichkey") })

		-- tmux
		use({ "aserowy/tmux.nvim", config = setup("tmux") })

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

		-- Yank/Clipboard manager (needs telescope or fzf)
		use({ "AckslD/nvim-neoclip.lua", config = setup("neoclip") })

		-- My own plugin
		use({ "~/workspace/danielws.vim/", config = setup("danielws") })

		-- Show symbols (emojis)
		use({ "nvim-telescope/telescope-symbols.nvim", wants = "telescope.vim" })

		-- Show cheatsheet for vim
		use({
			"sudormrfbin/cheatsheet.nvim",
			wants = {
				{ "nvim-telescope/telescope.nvim" },
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
			},
		})

		-- Ag for Telescope
		use({ "kelly-lin/telescope-ag", wants = { { "nvim-telescope/telescope.nvim" } } })

		-- Search keymapping
		-- This one can became a good option in the feature but at now it is unable to read the mappings from whichkey
		-- use({ "FeiyouG/command_center.nvim", wants = { "nvim-telescope/telescope.nvim" } })

		use({ "rmagatti/auto-session", config = setup("session") })

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			-- opt = true,
			-- cmd = { "Telescope" },
			-- module = "telescope",
			-- keys = { "<leader>f" },
			config = setup("telescope"),
			wants = {
				"plenary.nvim",
				"popup.nvim",
				"telescope-fzf-native.nvim",
				"telescope-project.nvim",
				"telescope-file-browser.nvim",
				"project.nvim",
				"nvim-neoclip.lua",
			},
			requires = {
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				"nvim-telescope/telescope-project.nvim",
				"nvim-telescope/telescope-file-browser.nvim",
				{ "ahmedkhalf/project.nvim", config = setup("project") },
				{ "rmagatti/session-lens", wants = { "auto-session" } },
			},
		})

		if first_sync then
			print("Restart Neovim required after installation!")
			require("packer").sync()
		end
	end
end

return Self
