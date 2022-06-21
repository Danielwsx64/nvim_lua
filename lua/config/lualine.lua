local Self = {}

function Self.setup()
	local status_ok, lualine = pcall(require, "lualine")

	if not status_ok then
		return
	end

	lualine.setup({
		options = { theme = "gruvbox", globalstatus = true },
		sections = { lualine_c = { { "filename", path = 1 } } },
	})
end

return Self
