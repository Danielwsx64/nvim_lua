local Self = {}

function Self.setup()
	local luasnip = require("luasnip")

	luasnip.config.set_config({
		history = false,
		updateevents = "TextChanged,TextChangedI",
	})

	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
end

return Self
