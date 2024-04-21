local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local lsp_compare = function(entry_one, entry_two)
	local types = require("cmp.types")
	local entry_one_kind = entry_one:get_kind()
	local entry_two_kind = entry_two:get_kind()

	-- Move text to lower priority
	entry_one_kind = entry_one_kind == types.lsp.CompletionItemKind.Text and 100 or entry_one_kind
	entry_two_kind = entry_two_kind == types.lsp.CompletionItemKind.Text and 100 or entry_two_kind

	-- Move Module to lower priority
	entry_one_kind = entry_one_kind == types.lsp.CompletionItemKind.Module and 99 or entry_one_kind
	entry_two_kind = entry_two_kind == types.lsp.CompletionItemKind.Module and 99 or entry_two_kind

	if entry_one_kind ~= entry_two_kind then
		local diff = entry_one_kind - entry_two_kind

		if diff < 0 then
			return true
		elseif diff > 0 then
			return false
		end
	end
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip",

		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-cmdline",
	},
	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local compare = require("cmp.config.compare")
		local luasnip = require("luasnip")

		luasnip.config.setup({
			history = false,
			updateevents = "TextChanged,TextChangedI",
		})

		require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })

		cmp.setup({
			completion = { completeopt = "menu,menuone,noinsert", keyword_length = 2 },
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			formatting = {
				format = function(entry, vim_item)
					vim_item.kind = kind_icons[vim_item.kind]
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snip]",
						buffer = "[Buffer]",
						nvim_lua = "[Lua]",
						path = "[Path]",
					})[entry.source.name]

					return vim_item
				end,
			},
			sorting = {
				priority_weight = 2,

				comparators = {
					compare.offset,
					compare.exact,
					-- compare.scopes,
					compare.score,
					compare.recently_used,
					compare.locality,
					lsp_compare,
					-- compare.kind,
					-- compare.sort_text,
					compare.length,
					compare.order,
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),

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
				end, { "i", "c" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{
					name = "buffer",
					option = {
						get_bufnrs = function()
							local bufs = {}
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								bufs[vim.api.nvim_win_get_buf(win)] = true
							end
							return vim.tbl_keys(bufs)
						end,
					},
				},
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})

		-- Use buffer source for `/`
		cmp.setup.cmdline("/", {
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':'
		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
