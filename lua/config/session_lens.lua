local Self = {}

function Self.setup()
	local status_ok, session_lens = pcall(require, "session-lens")

	if not status_ok then
		return
	end

	require("auto-session").setup({
		log_level = "info",
		auto_session_suppress_dirs = { "~/", "~/WsLW" },
	})

	session_lens.setup({
		path_display = { "shorten" },
	})
end

return Self
