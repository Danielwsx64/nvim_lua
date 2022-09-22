local Self = {}

-- Tmux integration
-- see: https://github.com/aserowy/tmux.nvim

function Self.setup()
	local status_ok, tmux = pcall(require, "tmux")

	if not status_ok then
		return
	end

	tmux.setup({
		copy_sync = { enable = false },
		navigation = { enable_default_keybindings = true, persist_zoom = true, cycle_navigation = true },
		resize = { enable_default_keybindings = true },
	})
end

return Self
