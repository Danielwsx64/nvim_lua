return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup({ window = { border = "single", position = "bottom" } })
		require("keymaping").register()
	end,
}
