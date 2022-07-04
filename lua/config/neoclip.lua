local Self = {}

function Self.setup()
	local status_ok, neoclip = pcall(require, "neoclip")

	if not status_ok then
		return
	end

	neoclip.setup({
		history = 100,
		enable_persistent_history = false,
		keys = {
			telescope = {
				i = {
					-- select = "<cr>",
					paste = "<cr>",
					paste_behind = "<c-p>",
					replay = "<c-q>", -- replay a macro
					delete = "<c-d>", -- delete an entry
				},
				n = {
					-- select = "<cr>",
					paste = "<cr>",
					paste_behind = "P",
					replay = "q",
					delete = "d",
				},
			},
		},
	})
end

return Self
