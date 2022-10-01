local Self = {}

function Self.config()
	local plugin = "tmux"
	local success, tmux = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	tmux.setup({
		copy_sync = { enable = false },
		navigation = { enable_default_keybindings = true, persist_zoom = true, cycle_navigation = true },
		resize = { enable_default_keybindings = true },
	})
end

return Self
