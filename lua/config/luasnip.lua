local Self = {}

function Self.setup()
	local luasnip = require("luasnip")

	luasnip.config.set_config({
		history = false,
		updateevents = "TextChanged,TextChangedI",
	})

	require("luasnip/loaders/from_vscode").load()
end

return Self