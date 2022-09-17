local Self = {}

function Self.setup()
	local lens_status_ok, session_lens = pcall(require, "session-lens")
	local auto_status_ok, auto_session = pcall(require, "auto-session")

	if not lens_status_ok or not auto_status_ok then
		return
	end

	auto_session.setup({
		log_level = "info",
		auto_session_enabled = true,
		auto_save_enabled = true,
		auto_restore_enabled = false,
		auto_session_suppress_dirs = { "~/", "~/workspace" },
	})

	-- session_lens.setup({
	-- 	path_display = { "shorten" },
	-- })
end

return Self
