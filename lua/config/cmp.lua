local Self = {
	packer = {
		wants = { "cmp-buffer", "cmp-path", "cmp-nvim-lua", "cmp-cmdline", "cmp-nvim-lsp", "cmp_luasnip", "LuaSnip" },
	},
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

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function Self.config()
	local plugin = "cmp"
	local success, cmp = pcall(require, plugin)

	if not success then
		vim.notify("Failed to load " .. plugin, vim.log.levels.ERROR)
		return
	end

	local luasnip = require("luasnip")
	local compare = require("cmp.config.compare")

	cmp.setup({
		completion = { completeopt = "menu,menuone,noinsert", keyword_length = 2 },
		experimental = { native_menu = false, ghost_text = false },
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
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
					-- treesitter = "[Treesitter]",
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
		mapping = {
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-n>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
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
			end, {
				"i",
				"s",
				"c",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
				"c",
			}),
		},
		sources = {
			{ name = "luasnip" },
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
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "path" },
			-- { name = "neorg" },
			-- { name = "orgmode" },
			-- { name = "treesitter" },
			-- { name = "spell" },
			-- { name = "emoji" },
			-- { name = "calc" },
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

	-- Auto pairs
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

return Self
