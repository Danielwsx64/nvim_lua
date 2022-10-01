local Self = {}

function Self.setup()
	local status_ok, comment = pcall(require, "Comment")

	if not status_ok then
		return
	end

	comment.setup()
end

return Self
