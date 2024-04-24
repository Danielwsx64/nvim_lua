local M = {}

local function noremap(mod, lhs, rhs, desc)
	vim.keymap.set(mod, lhs, rhs, { desc = desc, silent = true })
end

local function xnoremap(mod, lhs, rhs, desc)
	vim.keymap.set(mod, lhs, rhs, { desc = desc, silent = true, expr = true })
end

local function map(mod, lhs, rhs, desc)
	vim.keymap.set(mod, lhs, rhs, { desc = desc, silent = true, remap = true })
end

function M.treesitter_refactor_keys()
	return {
		smart_rename = {
			smart_rename = "<leader>lr",
		},
		navigation = {
			goto_definition = false,
			list_definitions = false,
			list_definitions_toc = false,
			goto_next_usage = "gn",
			goto_previous_usage = "gp",
		},
	}
end

function M.luasnip_remaps(luasnip)
	noremap({ "s", "i" }, "<c-n>", function()
		if luasnip.choice_active() then
			luasnip.change_choice(1)
		end
	end, "LuaSnip next choice")

	noremap({ "s", "i" }, "<c-p>", function()
		if luasnip.choice_active() then
			luasnip.change_choice(-1)
		end
	end, "LuaSnip previous choice")
end

function M.cmp_keys(cmp, luasnip)
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	return cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping(function()
			cmp.select_prev_item()
		end, { "i", "c" }),
		["<C-j>"] = cmp.mapping(function()
			cmp.select_next_item()
		end, { "i", "c" }),

		-- Scroll the documentation window [b]ack / [f]orward
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Accept ([y]es) the completion.
		--  This will auto-import if your LSP supports it.
		--  This will expand snippets if the LSP sent a snippet.
		["<C-y>"] = cmp.mapping.confirm({ select = true }),

		-- If you prefer more traditional completion keymaps,
		-- you can uncomment the following lines
		["<CR>"] = cmp.mapping({
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s", "c" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s", "c" }),

		["<Esc>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.close()
			else
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, true, true), "n", true)
			end
		end, { "c" }),
	})
end

--==================
--== Treesitter Keys
--==================
function M.treesitter_incremental_selec_keys()
	return {
		init_selection = "<leader>vv",
		node_incremental = "<leader>va",
		scope_incremental = "<leader>ve",
		node_decremental = "<leader>vd",
	}
end

--================
--== LSP Keys
--================
function M.register_lsp_keys(client, bufnr)
	local telescope = require("telescope.builtin")

	local leader_l_keys = {
		name = "Code LSP / Diagnostics",
		a = { vim.lsp.buf.code_action, "[L]SP Code [A]ction" },
		d = { vim.diagnostic.open_float, "[L]ine [D]iagnostics" },
		k = { vim.lsp.buf.hover, "LSP symbol info" },
		n = { vim.diagnostic.goto_next, "[G]oto [N]ext diagnostic line" },
		p = { vim.diagnostic.goto_prev, "[G]oto [P]rev diagnostic line" },
		s = { telescope.lsp_document_symbols, "[L]SP Document [S]ymbols" },
	}

	if client.server_capabilities.renameProvider then
		leader_l_keys["r"] = { vim.lsp.buf.rename, "[L]SP [R]ename" }
	end

	require("which-key").register({
		name = "Goto",
		D = { vim.lsp.buf.declaration, "[G]oto [D]eclaration" },
		I = { telescope.lsp_implementations, "[G]oto [I]mplementation" },
		d = { telescope.lsp_definitions, "[G]oto [D]efinition" },
		h = { vim.lsp.buf.hover, "[G]o [H]over Documentation" },
		r = { telescope.lsp_references, "[G]oto [R]eferences" },
		s = { vim.lsp.buf.signature_help, "[G]oto [S]ignature Help" },
		t = { telescope.lsp_type_definitions, "[G]oto [T]ype Definition" },
	}, { mode = "n", noremap = true, silent = true, buffer = bufnr, prefix = "g" })

	require("which-key").register({
		l = leader_l_keys,
	}, { mode = "n", noremap = true, silent = true, buffer = bufnr, prefix = "<leader>" })
end

--================
--== NvimTree Keys
--================
function M.register_tree_keys(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
end

--===========================
--== Visual Multi Cursor Keys
--===========================
function M.register_multi_cursor_keys()
	vim.cmd([[ 
    let g:VM_leader                     = {'default': '<leader>m', 'visual': '<leader>m', 'buffer': '<leader>m'}
    let g:VM_theme                      = 'olive'
    let g:VM_maps                       = {}
    let g:VM_maps["Add Cursor Down"]    = '<M-n>'    " new cursor down
    let g:VM_maps["Add Cursor Up"]      = '<M-m>'    " new cursor up
    let g:VM_maps['Select All']         = '<C-a>'    " select all
    let g:VM_maps['Visual All']         = '<C-a>'
    let g:VM_maps['Start Regex Search'] = '<C-_>'
  ]])
end

function M.register()
	local telescope = require("telescope.builtin")

	local visual_lead_binds = {
		["?"] = { "<CMD>WhichKey<CR>", "Help" },

		g = {
			name = "Git",

			O = { '<CMD>lua require("custom_commands").open_in_browser("v")<CR>', "Open in browser" },
			y = { '<CMD>lua require("custom_commands").copy_link("v")<CR>', "Copy repository link" },
		},
	}

	local normal_lead_binds = {
		["?"] = { "<CMD>WhichKey<CR>", "Help" },

		-- help
		h = {
			h = { telescope.help_tags, "Open help" },
			s = { "<CMD>Telescope luasnip<CR>", "Open spnipets" },
			S = { "<CMD>lua require('luasnip.loaders').edit_snippet_files()<CR>", "Edit Snippets" },
		},

		-- Quit commands
		q = {
			name = "Quit",
			q = { "<CMD>q<CR>", "Quit current window" },
			a = { "<CMD>qa<CR>", "Quit all" },
			f = { "<CMD>qa!<CR>", "All force" },
			F = { "<CMD>q!<CR>", "Force" },
			x = { "<CMD>x<CR>", "Quit saving" },
			X = { "<CMD>xa<CR>", "Quit saving" },
		},

		-- Explorer commands
		e = {
			name = "File explorer",
			f = { "<CMD>NvimTreeFindFile<CR>", "Open current buffer" },
			e = { "<CMD>NvimTreeToggle<CR>", "Open" },
			q = { "<CMD>NvimTreeClose<CR>", "Close" },
		},

		-- Telescope commands
		["<space>"] = {
			name = "Telescope finders",

			h = { telescope.command_history, "Commands history" },
			f = { telescope.find_files, "Files" },
			b = { telescope.buffers, "Buffers" },
			c = { telescope.commands, "Commands" },
			z = { telescope.builtin, "Sholl all pickers" },
			M = { telescope.keymaps, "Show keymaps" },
			j = { telescope.jumplist, "Jump list" },
			m = { telescope.marks, "Marks" },
			n = { "<CMD>Telescope notify<CR>", "Notifications" },
			y = { "<CMD>Telescope yank_history<CR>", "Yank History" },
			s = { telescope.spell_suggest, "Spell sugestion" },
			u = { "<CMD>UndotreeToggle<CR>", "Toggle Undo History" },

			["<space>"] = { telescope.resume, "Reopen last" },
		},

		-- Find with Hop or format
		f = {
			name = "Find or Format",

			g = { telescope.live_grep, "Live Grep" },
			a = { ":Danielws ag ", "Search with ag" },
			s = { telescope.current_buffer_fuzzy_find, "Current Buffer" },
			S = { telescope.grep_string, "Search word under cursor in workspace" },
			h = { telescope.search_history, "Show the search history" },

			c = { "<CMD>HopCamelCase<CR>", "-- HOP: Find for cammel case" },
			l = { "<CMD>HopLineStart<CR>", "-- HOP: Find for line" },
			w = { "<CMD>HopWord<CR>", "-- HOP: Find for word" },

			t = { "<CMD>ElixirDev jump_to_test<CR>", "Test file or back" },

			-- formaters
			p = { "<CMD>ElixirDev pipelize<CR>", "Elixir turns into pipe" },
			f = { "<CMD>ElixirDev fn_shorthand<CR>", "Elixir switch fn syntax" },
			k = { "<CMD>ElixirDev switch_keys<CR>", "Elixir switch map key syntax" },
		},

		-- LSP commands
		l = {
			name = "LSP commands",
			f = { telescope.diagnostics, "List diagnostics" },
		},

		-- Buffer commands
		b = {
			name = "Buffer",
			r = { "<CMD>e!<CR>", "Reload" },
			f = { "<CMD>Format<CR>", "Format" },

			l = { "<c-^>", "Go last" },

			d = { "<CMD>bd!<CR>", "Delete current" },
			D = { "<CMD>%bd|e#|bd#<CR>", "Delete all" },
		},

		-- Windows commands
		w = {
			name = "Windows",

			f = { "<CMD>res<CR><CMD>vert res<CR>", "Windows Full mode" },
			e = { "<CMD>wincmd =<CR>", "All windows same size" },
			E = { "<CMD>wincmd = | Danielws tmux resize_vim_pane 50<CR>", "Equal tmux vim pane" },
			z = { "<CMD>Danielws tmux resize_vim_pane z<CR>", "Full screen vim Tmux pane" },
			c = { "<CMD>Danielws tmux resize_vim_pane 65<CR>", "Resize tmux vim pane" },

			h = { "<CMD>lua require('tmux.navigation.navigate').to('h')<CR>", "Go left" },
			l = { "<CMD>lua require('tmux.navigation.navigate').to('l')<CR>", "Go right" },
			k = { "<CMD>lua require('tmux.navigation.navigate').to('k')<CR>", "Go top" },
			j = { "<CMD>lua require('tmux.navigation.navigate').to('j')<CR>", "Go down" },

			n = { "<CMD>vnew<CR>", "New vertical" },
			m = { "<CMD>new<CR>", "New horizontal" },

			v = { "<CMD>vsplit<CR>", "Split vertical" },
			s = { "<CMD>split<CR>", "Split horizontal" },

			i = { "<CMD>wincmd x<CR>", "Invert" },
			r = { "<CMD>wincmd J<CR>", "Rotate vertical" },
			R = { "<CMD>wincmd H<CR>", "Rotate horizontal" },

			o = { "<CMD>wincmd o<CR>", "Close others" },
			t = { "<CMD>wincmd T<CR>", "Move to new tab" },

			w = { "<CMD>update<CR>", "Save current buffer" },
			a = { "<CMD>wa<CR>", "Save all buffers" },
			x = { "<CMD>x<CR>", "Save & Quit" },
			q = { "<CMD>q<CR>", "Quit current" },
		},

		-- Search, Substitute
		s = {
			name = "Search and Substitute",

			n = { "<CMD>Danielws better_search<CR>", "Search word under cursor" },
			r = { "<CMD>Danielws better_replace<CR>", "Find and replace word near the cursor" },
		},

		-- Tabs and Tmux moves commands
		t = {
			name = "Tabs and Tmux moves",
			b = { "<CMD>tabm -<CR>", "Move back" },
			f = { "<CMD>tabm +<CR>", "Move forward" },

			h = { "<CMD>tabp<CR>", "Go left" },
			l = { "<CMD>tabn<CR>", "Go right" },

			j = { "<CMD>tabr<CR>", "Go first" },
			k = { "<CMD>tabl<CR>", "Go last" },

			o = { "<CMD>tabo<CR>", "Close othes" },
			q = { "<CMD>tabc<CR>", "Close" },

			s = { "<CMD>tab split<CR>", "Split current buffer in a new tab" },
			S = { "<CMD>tabs<CR>", "Show all" },

			n = { "<CMD>tabnew<CR>", "New" },

			t = {
				name = "Tmux moves",
				n = { "<CMD>Danielws tmux new_window<CR>", "Create a new tmux window" },
				l = { "<CMD>Danielws tmux next_window<CR>", "Move to next window" },
				h = { "<CMD>Danielws tmux previous_window<CR>", "Move to previous window" },
				b = { "<CMD>Danielws tmux last_window<CR>", "Move to last window" },
				v = { "<CMD>Danielws tmux window_split h<CR>", "Split window v" },
				s = { "<CMD>Danielws tmux window_split v<CR>", "Split window" },
			},
		},

		-- Run tests and shell commands
		r = {
			name = "Run tests and shell",

			s = { "<CMD>TestFile<CR>", "Test file" },
			n = { "<CMD>TestNearest<CR>", "Test Nearest" },
			l = { "<CMD>TestLast<CR>", "Test last" },
			a = { "<CMD>TestSuite<CR>", "Test all" },
			V = { "<CMD>TestVisit<CR>", "Go to last test file" },

			b = { "<CMD>VtrSendCommand !!<CR>", "Run back last terminal command" },

			v = { "<CMD>:VtrAttachToPane<CR>", "Reattach tmux pane" },
		},

		-- Git commands
		g = {
			name = "Git",
			n = { "<CMD>lua require('gitsigns').next_hunk()<CR>", "Next hunk" },
			p = { "<CMD>lua require('gitsigns').prev_hunk()<CR>", "Previous hunk" },
			d = { "<CMD>lua require('gitsigns').preview_hunk()<CR>", "Diff hunk" },
			D = { "<CMD>lua require('gitsigns').diffthis()<CR>", "Diff buffer" },
			b = { "<CMD>lua require('gitsigns').blame_line{full=true}<CR>", "Blame line" },
			B = { "<CMD>lua require('gitsigns').toggle_current_line_blame()<CR>", "Buffer blame" },
			h = { "<CMD>DiffviewFileHistory %<CR>", "Buffer history" },
			L = { "<CMD>DiffviewFileHistory<CR>", "DiffView log" },

			o = { "<CMD>Neogit<CR>", "Open NeoGit" },
			s = { telescope.git_status, "Status" },
			l = { telescope.git_commits, "Log" },
			O = { '<CMD>lua require("custom_commands").open_in_browser("n")<CR>', "Open in browser" },
			y = { '<CMD>lua require("custom_commands").copy_link("n")<CR>', "Copy repository link" },
		},

		["<ESC>"] = { "<CMD>nohlsearch<CR>", "Cancel search" },
	}

	-- Better escape using jk in insert and terminal mode
	noremap("i", "jk", "<ESC>", "Scape with jk same as <ESC>")
	-- noremap("t", "jk", "<C-\\><C-n>", "")

	-- Center search results
	noremap("n", "n", "nzz", "Go to next found")
	noremap("n", "N", "Nzz", "Go to previous found")

	-- Visual line wraps
	xnoremap("n", "k", "v:count == 0 ? 'gk' : 'k'", "Move up")
	xnoremap("n", "j", "v:count == 0 ? 'gj' : 'j'", "Move down")

	-- Better indent
	noremap("v", "<", "<gv", "Indent and reselect")
	noremap("v", ">", ">gv", "Remove indent and reselect")

	-- Move selected line / block of text in visual mode
	noremap("x", "<Up>", ":move '<-2<CR>gv-gv", "Move selected up")
	noremap("x", "<Down>", ":move '>+1<CR>gv-gv", "Move seleced down")

	-- better search
	map("n", "*", "<CMD>Danielws better_search<CR>", "Search foward word under cursor")
	map("v", "*", "<CMD>Danielws better_search<CR>", "Search foward selection")

	-- Avoid starting macro recording by chance
	noremap("n", "Q", "q", "Record macro")
	noremap("n", "q", "<Nop>", "Nothing")

	local hop = require("hop")
	local directions = require("hop.hint").HintDirection

	vim.keymap.set("", "f", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
	end, { remap = true })

	vim.keymap.set("", "F", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	end, { remap = true })

	vim.keymap.set("", "t", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
	end, { remap = true })

	vim.keymap.set("", "T", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
	end, { remap = true })

	local whichkey = require("which-key")

	whichkey.register(normal_lead_binds, {
		mode = "n", -- Normal mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	})

	whichkey.register(visual_lead_binds, {
		mode = "v", -- Normal mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	})
end

return M
