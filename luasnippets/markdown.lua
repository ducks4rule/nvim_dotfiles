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
  s({trig="bf", dscr="bold face"},
    fmta(
      "**<>**",
      { d(1, get_visual), }
    )
  ),
  s({trig="it", dscr="italic"},
    fmta(
      "*<>*",
      { d(1, get_visual), }
    )
  ),

  s({trig="link", dscr="inline link"},
    fmta(
      "[<>](<>)",
      { d(1, get_visual), i(2, "https://"), }
    )
  ),
  s({trig="img", dscr="inline image"},
    fmta(
      "![<>](<>)",
      { d(1, get_visual), i(2, "https://"), }
    )
  ),
  s({trig="code", dscr="inline code"},
    fmta(
      "`<>`",
      { d(1, get_visual), }
    )
  ),
  s({trig="codeb", dscr="block code"},
    fmta(
      "```<>",
      { d(1, get_visual), }
    )
  ),
  s({trig="math", dscr="inline math"},
    fmta(
      "$<>$",
      { d(1, get_visual), }
    )
  ),
  s({trig="mathb", dscr="block math"},
    fmta(
      "$$<>$$",
      { d(1, get_visual), }
    )
  ),
  -- s({trig="quote", dscr="quote"},
  --   fmta(
  --     "> <>",
  --     { d(1, get_visual), }
  --   )
  -- ),

  s({trig="deflink", dscr="define link"},
    fmta(
      "[<>]: <>",
      { d(1, get_visual), i(2, "https://"), }
    )
  ),
  s({trig="defimg", dscr="define image"},
    fmta(
      "![<>]: <>",
      { d(1, get_visual), i(2, "https://"), }
    )
  ),

  -- GitHub callout blocks
  s({trig="note", dscr="callout note"},
    fmta("> [!NOTE]\n> <>", { d(1, get_visual) })
  ),
  s({trig="warn", dscr="callout warning"},
    fmta("> [!WARNING]\n> <>", { d(1, get_visual) })
  ),
  s({trig="tip", dscr="callout tip"},
    fmta("> [!TIP]\n> <>", { d(1, get_visual) })
  ),
  s({trig="imp", dscr="callout important"},
    fmta("> [!IMPORTANT]\n> <>", { d(1, get_visual) })
  ),
  s({trig="caut", dscr="callout caution"},
    fmta("> [!CAUTION]\n> <>", { d(1, get_visual) })
  ),
}
