local setup = require("config.setup").setup

local Self = {}

function Self.get_plugins(first_sync)
	return function(use)
		use("wbthomason/packer.nvim")

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
