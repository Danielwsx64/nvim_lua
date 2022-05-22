local Self = {}

-- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
-- see: https://github.com/TimUntersberger/neogit

function Self.setup()
	local status_ok, neogit = pcall(require, "neogit")

	if not status_ok then
		return
	end

	neogit.setup({})
end

return Self
