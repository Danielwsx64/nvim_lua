local api = vim.api
local Self = {}

local servers = {
	elixirls = {},
	html = {},
	jsonls = {},
	rust_analyzer = {},
	sumneko_lua = {},
	tsserver = {},
	vimls = {},
}

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true
-- }
-- local language_servers = {} -- like {'gopls', 'clangd'}
-- for _, ls in ipairs(language_servers) do
--     require('lspconfig')[ls].setup({
--         capabilities = capabilities,
--         other_fields = ...
--     })
-- end

local function on_attach(client, bufnr)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- Configure key mappings
	require("config.whichkey.lsp").setup(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- To fold by LSP with UFO lib
capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
local default_opts = { on_attach = on_attach, capabilities = cmp_capabilities, flags = { debounce_text_changes = 150 } }

function Self.setup()
	require("lsp_signature").setup({
		bind = true,
		handler_opts = {
			border = "rounded",
		},
	})

	require("config.lsp.installer").setup(servers, default_opts)
end

return Self
