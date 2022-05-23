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
		use({ "TimUntersberger/neogit", config = setup("neogit"), requires = "nvim-lua/plenary.nvim" })

		-- Show keymapping hits
		use({ "folke/which-key.nvim", config = setup("whichkey") })

		-- Some usefull plugins to use
		-- https://github.com/Shatur/neovim-session-manager

		if first_sync then
			print("Restart Neovim required after installation!")
			require("packer").sync()
		end
	end
end

return Self
