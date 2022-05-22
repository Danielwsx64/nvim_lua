local g = vim.g
local cmd = vim.cmd

local Self = {}

-- High Contrast & Vivid Color Scheme based on Monokai Pro
-- see: https://github.com/sainnhe/sonokai

function Self.setup()
	g.sonokai_style = "espresso"
	g.sonokai_better_performance = 1

	cmd("colorscheme sonokai")
end

return Self
