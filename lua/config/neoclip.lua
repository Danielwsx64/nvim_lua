local Self = {}

function Self.config()
	local plugin = "neoclip"
	local success, neoclip = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
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
