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

-- snippets
return{
  s({trig="sec", dscr="bigest section"},
    fmta(
      "= <>",
      { d(1, get_visual), }
    )
  ),
  s({trig="ssec", dscr="sub section"},
    fmta(
      "== <>",
      { d(1, get_visual), }
    )
  ),
  s({trig="sssec", dscr="subsub section"},
    fmta(
      "=== <>",
      { d(1, get_visual), }
    )
  ),
  s({trig="ssssec", dscr="subsubsusb section"},
    fmta(
      "==== <>",
      { d(1, get_visual), }
    )
  ),

  s({trig="bf", dscr="bold face"},
    fmta(
      "*<>*",
      { d(1, get_visual), }
    )
  ),
  s({trig="it", dscr="italic"},
    fmta(
      "_<>_",
      { d(1, get_visual), }
    )
  ),

  s({trig="fig", dscr="figure environment"},
    fmta(
      [[
        #figure(
            placement: <>,
            <>
            caption: [<>],
         ) <<<>>>
      ]],
      {
        i(1, "bottom"),
        i(2, "image/table"),
        i(3, "caption"),
        i(4, "label"),
      }
    )
  ),
  s({trig="im", dscr="insert image"},
    fmta(
      "<>(\"<>\", width: <>)",
      {
        c(1, {t("image"), t("#image")}),
        i(2, "path"),
        i(3, "100%"),
      }
    )
  ),
  s({trig="gr", dscr="grid function"},
    fmta(
      [[
        grid(columns: <>,
            <> <>
        )
      ]],
      {
        i(1, "2"),
        c(2, {sn(nil, {i(1), t(",")}),
          sn(nil, {t("row-gutter: "),i(1, "0.5em"),t({",",""})}),
          sn(nil, {t("column-gutter: "),i(1, "1em"),t({",",""})}),
          sn(nil, {t("row-gutter: "),i(1, "0.5em"),t({",",""}),
                  t("column-gutter: "),i(2, "1m"),t({",",""})}),
        }),
        i(3, "content"),
      }
    )
  ),


  -- ===================
  -- Math
  -- ===================
  s({trig ="([^%a])mm", dscr="in line math mode '$ $'",
            regTrig = true, wordTrig = false,
            snippetType="autosnippet"},
    fmta(
      "<>$<>$",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  s({trig="dm", dscr="display math", snippetType="autosnippet"},
    fmta(
      [[
        $
            <>
        $<>
      ]],
      {
        d(1, get_visual),
        c(2, {t(""), sn(nil, {t("<eq_"),i(1),t(">")})})
      }
    ),
    {condition = line_begin}
  ),
}
