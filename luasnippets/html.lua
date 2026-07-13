-- local snippet vars
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local helpers = require("user.snippets.snippet_helper_functions")
local get_visual = helpers.get_visual
-- local in_env = helpers.in_env
local in_text = helpers.in_text
local in_preamble = helpers.in_preamble
local space_to_uscore = helpers.space_to_uscore


return{
  s({trig="bf", dscr="bold face"},
    fmta(
      "<<strong>><><</stron>>",
      { d(1, get_visual), }
    )
  ),
  s({trig="col", dscr="text color"},
    fmta(
      "<<font color=\"<>\">><><</font>>",
      {
        i(1, "blue"),
        d(2, get_visual),
      }
    )
  ),
}
