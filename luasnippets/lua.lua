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



return{
-- snippets

  -- fmta snippets
  s({trig="sn", dscr="Template for writing snippets with fmta"},
    fmt(
      [[
        s({trig="<>", dscr=<>},
          fmta(
            <>,
            {<>}
          )<>
        ),
      ]],
      {
        i(1, "trigger"),
        c(2, {sn(nil, {t("\""),i(1),t("\"")}), sn(nil, {t("\""),i(1),t("\", snippetType=\"autosnippet\"")})}),
        c(3, {sn(nil, {t("\""), i(1), t("\"")}),
                 sn(nil, {t({"[[", "      "}), i(1), t({"","    ]]"})})}),
        c(4, {sn(nil, {t(" "),i(1),t(" ")}),
                sn(nil,{t({"","      "}),i(1),t({"","    "})})
        }),
        c(5, {t(""),
            t({",","  {condition = line_begin}"}),
            t({",","  {condition = in_math}"})})
      },
      {delimiters = "<>"}
    )
  ),

  -- simple text node snippets
  s({trig="st", dscr="Simple 'one text node' snippet"},
    fmt(
      [[
        s({trig="<>", dscr=<>},
          {
            t(<>)
          }<>
        ),
      ]],
      {
        i(1, "trigger"),
        c(2, {sn(nil, {t("\""),i(1),t("\"")}), sn(nil, {t("\""),i(1),t("\", snippetType=\"autosnippet\"")}),sn(nil, {t("\""),i(1),t("\", snippetType=\"autosnippet\", wordTrig=false")})}),
        c(3, {sn(nil, {t("\""),i(1),t("\"")}), sn(nil, {t({"[[","    "}),i(1),t({"","    ]]"})})}),
        c(4, {t(""),
            t({",","  {condition = line_begin}"}),
            t({",","  {condition = in_math}"})})
      },
      {delimiters = "<>"}
    )
  ),

  -- regex snippet
  s({trig="sr", dscr="write regex snippets"},
    fmta(
      [[
        s({trig = "([<>])<>", dscr="<>",
                    wordTrig = <>, regTrig = <><>},
          fmta(
            "<<>><>",
            {
              f( function(_, snip) return snip.captures[1] end ),
              <>,
            }
          )
        ),
      ]],
      {
        i(1, "^%a"),
        i(2, "trig"),
        i(3, "description"),
        i(4, "false"),
        i(5, "true"),
        c(6, {t(", snippetType=\"autosnippet\""),t("")}),
        i(7, "snippet"),
        i(8, "nodes"),
      }
    ),
    {}
  ),


  -- snippet accessories
  s({trig="conb",snippetType="autosnippet", dscr="condition: at the beginning of line"},
    {
      t("{condition = line_begin}")
    }
  ),

  s({trig="conm",snippetType="autosnippet", dscr="condition: in mathmode"},
    {
      t("{condition = in_math}")
    }
  ),
  s({trig="aus", dscr="auto snippet option"},
    {
      t("snippetType=\"autosnippet\"")
    }
  ),
  s({trig="wt", dscr="wort trig"},
    {
      t("wordTrig="), c(1, {t("false"), t("true")})
    }
  ),

  -- nodes
  s({trig="dn", dscr="dynamic node for snippets", snippetType="autosnippet"},
    fmta(
      "d(<>, <>),",
      {
        i(1,"1"),
        i(2, "get_visual"),
      }
    )
  ),
  s({trig="cn", dscr="choice node", snippetType="autosnippet"},
    fmta(
      "c(<>, {<>})",
      {
        i(1, "1"),
        i(2)
      }
    )
  ),
  s({trig="snn", dscr="snippet node", snippetType="autosnippet"},
    fmta(
      "sn(<>, <>)",
      {
        i(1, "nil"),
        c(1, {sn(nil, fmta("{<>}", {i(1)})), sn(nil, fmta(
          [[
            fmta(
              <>,
              { <> }
            )
          ]],
          {i(1), i(2)}
        ))})
      }
    )
  ),
  s({trig="in", dscr="insert node"},
    fmta(
      "i(<>)",
      { i(1,"1") }
    )
  ),
  s({trig="tn", dscr="text node", snippetType="autosnippet"},
    fmta(
      "t(<>)",
      { c(1, {sn(nil, {t("\""), i(1), t("\"")}),
                sn(nil, {t("{\""), i(1), t("\"}")})}) }
    )
  ),

  s({trig="gr", dscr="greek letters"},
    fmta(
      [[
        s({trig="<>", dscr="\\<>", snippetType="autosnippet"},
          {
            t("\\<>")
          },
          {condition = in_math}
        ),
      ]],
      {
        i(1),
        i(2),
        rep(2)
      }
    ),
    {condition = line_begin}
  ),
}
