local Self = { packer = { wants = "friendly-snippets" } }

function Self.config()
	local plugin = "luasnip"
	local success, luasnip = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	luasnip.config.set_config({
		history = false,
		updateevents = "TextChanged,TextChangedI",
	})

	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
end

return Self
