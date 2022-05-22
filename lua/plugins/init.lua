local Self = {}
local setup = require("config.setup").setup

function Self.get_plugins(first_sync)
	return function(use)
		use("wbthomason/packer.nvim")

		-- Startup screen
		use({ "goolord/alpha-nvim", config = setup("alpha") })

		-- Git
		use({ "TimUntersberger/neogit", config = setup("neogit"), requires = "nvim-lua/plenary.nvim" })

		-- Some usefull plugins to use
		-- https://github.com/Shatur/neovim-session-manager

		-- Colorscheme
		-- use({
		-- 	"sainnhe/sonokai",
		-- 	config = function()
		-- 		cmd("colorscheme sonokai")
		-- 	end,
		-- })

		if first_sync then
			print("Restart Neovim required after installation!")
			require("packer").sync()
		end
	end
end

return Self
