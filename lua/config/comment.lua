local Self = {}

function Self.config()
	local plugin = "nvim_comment"
	local success, nvim_comment = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	nvim_comment.setup({
		-- Linters prefer comment and line to have a space in between markers
		marker_padding = true,
		-- should comment out empty or whitespace only lines
		comment_empty = true,
		-- trim empty comment whitespace
		comment_empty_trim_whitespace = true,
		-- Should key mappings be created
		create_mappings = true,
		-- Normal mode mapping left hand side
		line_mapping = "gss",
		-- Visual/Operator mapping left hand side
		operator_mapping = "gs",
		-- text object mapping, comment chunk,,
		comment_chunk_text_object = "is",
		-- Hook function to call before commenting takes place
		hook = nil,
	})
end

return Self
