local Self = {}

function Self.add_maps(client, bufnr)
	local whichkey = require("which-key")
	-- keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	-- Whichkey
	local keymap_l = {
		l = {
			name = "Code LSP / Diagnostics",
			r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
			i = { "<cmd>LspInfo<CR>", "Lsp Info" },
			k = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "LSP symbol info" },
			R = { "<cmd>lua vim.lsp.buf.references()<CR>", "Send references to quickfix list" },
			n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic line" },
			p = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to prev diagnostic line" },
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
	}

	whichkey.register(keymap_l, { mode = "n", noremap = true, silent = true, buffer = bufnr, prefix = "<leader>" })
	whichkey.register(keymap_g, { mode = "n", noremap = true, silent = true, buffer = bufnr, prefix = "g" })
end

return Self
