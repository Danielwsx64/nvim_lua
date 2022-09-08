local Self = {}
local o = vim.o

-- Plugin to better folding
function Self.setup()
	local status_ok, ufo = pcall(require, "ufo")
	if not status_ok then
		return
	end

	-- With zero it removes the fold information from left column
	o.foldcolumn = "0"
	o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	o.foldlevelstart = 99
	o.foldenable = true

	ufo.setup({})
end

return Self
