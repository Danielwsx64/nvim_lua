local Self = {}

local servers = {
	taplo = {},
	dockerls = {},
	cssls = {},
	terraformls = {},
	elixirls = {},
	ruby_ls = {},
	html = {},
	jsonls = {},
	rust_analyzer = {},
	tsserver = {},
	vimls = {},
	lua_ls = {
		settings = {
			Lua = {
				-- Tells Lua that a global variable named vim exists to not have warnings when configuring neovim
				diagnostics = { globals = { "vim", "it", "describe" } },

				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	},
}

function Self.config()
	local plugin = "mason-lspconfig"
	local success, mason_lspconfig = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	local mason_success, mason = pcall(require, "mason")

	if not mason_success then
		vim.notify("Failed to load mason", vim.log.levels.ERROR)
		return
	end

	local lspconfig_success, lspconfig = pcall(require, "lspconfig")
	if not lspconfig_success then
		vim.notify("Failed to load lspconfig", vim.log.levels.ERROR)
		return
	end

	local lsp_signature_success, lsp_signature = pcall(require, "lsp_signature")

	if lsp_signature_success then
		lsp_signature.setup({ bind = true, handler_opts = { border = "rounded" } })
	else
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
	end

	mason.setup({
		ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } },
	})

	mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })

	Self.diagnostics_config()
	Self.build_capabilities()

	mason_lspconfig.setup_handlers({
		-- The first entry (without a key) will be the default handler
		-- and will be called for each installed server that doesn't have
		-- a dedicated handler.
		function(server_name) -- Default handler (optional)
			lspconfig[server_name].setup({
				on_attach = Self.on_attach,
				capabilities = Self.capabilities,
				settings = servers[server_name].settings,
			})
		end,

		-- Next, you can provide targeted overrides for specific servers.
		-- For example, a handler override for the `rust_analyzer`:
		-- ["rust_analyzer"] = function()
		-- 	require("rust-tools").setup({})
		-- end,

		-- ["jsonls"] = function()
		-- 	-- Find more schemas here: https://www.schemastore.org/json/
		-- 	-- Schemas for common json files
		--
		-- 	lspconfig.jsonls.setup({
		-- 		on_attach = Self.on_attach,
		-- 		capabilities = Self.capabilities,
		-- 		settings = { json = { schemas = schemas } },
		-- 	})
		-- end,
	})
end

function Self.diagnostics_config()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = true, -- disable virtual text
		signs = { active = signs },
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

function Self.build_capabilities()
	local plugin = "cmp_nvim_lsp"
	local success, cmp_nvim_lsp = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	Self.capabilities = cmp_nvim_lsp.default_capabilities()
end

function Self.on_attach(client, bufnr)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- Configure key mappings
	require("config.whichkey.lsp").add_maps(client, bufnr)
end

return Self
