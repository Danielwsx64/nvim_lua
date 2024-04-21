return {
	"mg979/vim-visual-multi",
	config = function()
		require("keymaping").register_multi_cursor_keys()
	end,
}
