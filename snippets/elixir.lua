local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
local d = ls.dynamic_node
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
	s({ trig = "defmo", dscr = "Define a new module" }, {
		t("defmodule "),
		d(1, module_name, {}),
		t({ " do", "" }),
		i(0),
		t({ "", "end" }),
	}),
	s({ trig = "exunit", dscr = "Define a new test module" }, {
		t("defmodule "),
		d(1, module_name, {}),
		t({ " do", "" }),
		t("\tuse "),
		i(2, "ExUnit"),
		t("."),
		i(3, "Case"),
		t(", async: "),
		i(4, "true"),
		t({ "", "\t" }),
		i(0),
		t({ "", "end" }),
	}),
}
