local ls = require("luasnip")

-- some shorthands...
local snippet = ls.snippet
local sn = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
local dynamic = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.expand_conditions")
-- local helper = require("snippets_helpers")

local function module_name()
	local module = "Module"

	local status_ok, elixir = pcall(require, "danielws.elixir")

	if status_ok then
		module = elixir.module_name_by_path()
	end

	return sn(nil, { i(1, module) })
end

return {
	snippet({ trig = "defmo", dscr = "Define a new module" }, {
		text("defmodule "),
		dynamic(1, module_name, {}),
		text({ " do", "" }),
		insert(0),
		text({ "", "end" }),
	}),
	snippet({ trig = "exunit", dscr = "Define a new test module" }, {
		text("defmodule "),
		dynamic(1, module_name, {}),
		text({ " do", "" }),
		text("\tuse "),
		insert(2, "ExUnit"),
		text("."),
		insert(3, "Case"),
		text(", async: "),
		insert(4, "true"),
		text({ "", "\t" }),
		insert(0),
		text({ "", "end" }),
	}),
}
