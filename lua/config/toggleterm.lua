local Self = {}

function Self.setup()
	local status_ok, toggleterm = pcall(require, "toggleterm")

	if not status_ok then
		return
	end

	toggleterm.setup({
		size = function(term)
			if term.direction == "horizontal" then
				return 20
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<c-t>]],
		shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
		start_in_insert = false,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
		persist_size = true,
		persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
		direction = "vertical", -- 'vertical' | 'horizontal' | 'tab' | | 'float'
		close_on_exit = true, -- close the terminal window when the process exits
		shell = vim.o.shell, -- change the default shell
		auto_scroll = true, -- automatically scroll to the bottom on terminal output
		hide_numbers = true, -- hide the number column in toggleterm buffers
		autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
		-- on_open = fun(t: Terminal), -- function to run when the terminal opens
		-- on_close = fun(t: Terminal), -- function to run when the terminal closes
		-- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
		-- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
		-- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
		-- shade_filetypes = {},
		-- highlights = {
		--   -- highlights which map to a highlight group name and a table of it's values
		--   -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
		--   Normal = {
		--     guibg = "<VALUE-HERE>",
		--   },
		--   NormalFloat = {
		--     link = 'Normal'
		--   },
		--   FloatBorder = {
		--     guifg = "<VALUE-HERE>",
		--     guibg = "<VALUE-HERE>",
		--   },
		-- },
		-- This field is only relevant if direction is set to 'float'
		float_opts = {
			-- The border key is *almost* the same as 'nvim_open_win'
			-- see :h nvim_open_win for details on borders however
			-- the 'curved' border is a custom border type
			-- not natively supported but implemented in this plugin.
			border = "curved", -- 'single' | 'double' | 'shadow' | | ... other options supported by win open
			-- like `size`, width and height can be a number or function which is passed the current terminal
			-- width = <value>,
			-- height = <value>,
			-- winblend = 3,
		},
		winbar = { enabled = false },
	})

	function _G.set_terminal_keymaps()
		local opts = { buffer = 0 }
		vim.keymap.set("t", "<space><esc>", [[<C-\><C-n>]], opts)
		-- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
		vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
		vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
		vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		vim.keymap.set("t", "<space>wh", [[<Cmd>wincmd h<CR>]], opts)
		vim.keymap.set("t", "<space>wj", [[<Cmd>wincmd j<CR>]], opts)
		vim.keymap.set("t", "<space>wk", [[<Cmd>wincmd k<CR>]], opts)
		vim.keymap.set("t", "<space>wl", [[<Cmd>wincmd l<CR>]], opts)
	end

	-- if you only want these mappings for toggle term use term://*toggleterm#* instead
	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
end

return Self
