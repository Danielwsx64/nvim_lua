local g = vim.g
local opt = vim.opt
local Self = {}

function Self.setup()
	opt.grepprg = "ag"
	g.grep_cmd_opts = "--line-numbers --noheading"
end

return Self
