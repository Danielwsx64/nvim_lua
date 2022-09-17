local Self = {}

function Self.setup()
	local status_ok, danielws = pcall(require, "danielws")

	if not status_ok then
		return
	end

	danielws.setup({ tmux_runner = { auto_attach = false } })
end

return Self
