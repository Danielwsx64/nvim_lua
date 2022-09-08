local g = vim.g
local cmd = vim.cmd

local Self = {}

-- High Contrast & Vivid Color Scheme based on Monokai Pro
-- see: https://github.com/sainnhe/sonokai

function Self.setup()
	-- g.sonokai_style = "andromeda"
	g.sonokai_style = "default"
	-- g.sonokai_style = "atlantis"
	g.sonokai_better_performance = 1

	cmd("colorscheme sonokai")
end

return Self
