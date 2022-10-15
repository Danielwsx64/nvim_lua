local Self = {}

function Self.config()
	local plugin = "zen-mode"
	local success, zenmode = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	zenmode.setup({
		-- window = {
		-- 	options = {
		-- 		signcolumn = "no", -- disable signcolumn
		-- 		number = false, -- disable number column
		-- 		relativenumber = false, -- disable relative numbers
		-- 		cursorline = false, -- disable cursorline
		-- 		cursorcolumn = false, -- disable cursor column
		-- 		foldcolumn = "0", -- disable fold column
		-- 		list = false, -- disable whitespace characters
		-- 	},
		-- },
		plugins = {
			-- options = {
			-- 	enabled = true,
			-- 	ruler = false, -- disables the ruler text in the cmd line area
			-- 	showcmd = false, -- disables the command in the last line of the screen
			-- },
			-- gitsigns = { enabled = false }, -- disables git signs
			tmux = { enabled = false }, -- disables the tmux statusline
		},
	})
end

return Self
