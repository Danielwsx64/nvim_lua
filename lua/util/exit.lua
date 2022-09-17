local Self = {}

function Self.close_session()
	vim.cmd("DeleteSession")
	vim.cmd("qa!")
end

function Self.quit_all()
	for _, buf in ipairs(vim.fn.getbufinfo()) do
		if buf.listed == 0 or not (vim.api.nvim_buf_get_option(buf.bufnr, "modifiable")) then
			vim.api.nvim_buf_delete(buf.bufnr, {})
			print("Deleted buf " .. buf.bufnr)
		end
	end

	vim.cmd("qa")
end

return Self
