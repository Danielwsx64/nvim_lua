return {
	"rcarriga/nvim-notify",
	config = function()
		vim.notify = require("notify")

		require("notify").setup({
			background_colour = "Normal",
			fps = 30,
			icons = {
				DEBUG = "",
				ERROR = "",
				INFO = "",
				TRACE = "✎",
				WARN = "",
			},
			level = 2,
			minimum_width = 50,
			render = "default",
			stages = "slide",
			-- we got an warning about guicolors
			-- stages = "fade_in_slide_out",
			timeout = 2000,
			top_down = true,
		})
	end,
}
