local Self = {}

function Self.config()
	vim.opt.grepprg = "ag"
	vim.g.grep_cmd_opts = "--line-numbers --noheading"
end

return Self
