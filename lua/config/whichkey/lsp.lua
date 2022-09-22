local api = vim.api
local whichkey = require("which-key")

-- local keymap = api.nvim_set_keymap
-- local buf_keymap = api.nvim_buf_set_keymap

local Self = {}

local function keymappings(client, bufnr)
	-- local opts = { noremap = true, silent = true }
	-- Key mappings
	-- buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	-- keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	-- keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
	-- keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)

	-- Whichkey
	local keymap_l = {
		l = {
			name = "Code",
			r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
			i = { "<cmd>LspInfo<CR>", "Lsp Info" },
		},
	}

	if client.server_capabilities.document_formatting then
		keymap_l.l.f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format Document" }
	end

	local keymap_g = {
		name = "Goto",
		d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
		I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
		t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
		h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Goto doc" },
		-- buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	}

	whichkey.register(keymap_l, { mode = "n", noremap = true, silent = true, buffer = bufnr, prefix = "<leader>" })
	whichkey.register(keymap_g, { mode = "n", noremap = true, silent = true, buffer = bufnr, prefix = "g" })
end

function Self.add_maps(client, bufnr)
	keymappings(client, bufnr)
end

return Self
