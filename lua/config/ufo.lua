local Self = {}

-- Plugin to better folding
function Self.config()
	local plugin = "ufo"
	local success, ufo = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	-- With zero it removes the fold information from left column
	vim.o.foldcolumn = "0"
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	ufo.setup({})
end

return Self
