-- local snippet vars
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local helpers = require("user.snippets.snippet_helper_functions")
local get_visual = helpers.get_visual
-- local in_env = helpers.in_env
local in_text = helpers.in_text
local space_to_uscore = helpers.space_to_uscore



return{
  -- preamble
  s({trig="nc", dscr="define new command"},
    fmta(
      "\\newcommand<>",
      {
        c(1, {sn(nil, fmta(
          "{<>}",
          { i(1) }
        )), sn(nil, fmta(
          "{<>}[<>]",
          { i(1), i(2) }
        ))})
      }
    )
  ),
  s({trig="pkg", dscr="use package"},
    fmta(
      "\\usepackage<>",
      { c(1, {sn(nil, fmta(
        "{<>}",
        { i(1) }
      )), sn(nil, fmta(
        "[<>]{<>}",
        { i(1), i(2) }
      ))}) }
    )
  ),
  s({trig="xs", dscr="x-space"},
    {
      t("\\xspace")
    }
  ),

  -- document structure
  s({trig="cha", dscr="chapter with optional label"},
    fmta(
      [[\chapter<>]],
      {
        c(1, {sn(nil, {t("{"),i(1),t("}")}),sn(nil, {t("{"),i(1),t({"}","\\label{chpt:"}),f(space_to_uscore,{1}),i(2),t("}")})})
      }
    )
  ),
  s({trig="sec", dscr="section with optional label"},
    fmta(
      [[\section<>]],
      {
        c(1, {sn(nil, {t("{"),i(1),t("}")}),sn(nil, {t("{"),i(1),t({"}","\\label{sec:"}),f(space_to_uscore,{1}),i(2),t("}")})})
      }
    )
  ),
  s({trig="sub", dscr="subsection with optional label"},
    fmta(
      [[\subsection<>]],
      {
        c(1, {sn(nil, {t("{"),i(1),t("}")}),sn(nil, {t("{"),i(1),t({"}","\\label{subsec:"}),f(space_to_uscore,{1}),i(2),t("}")})})
      }
    )
  ),
  s({trig="subsub", dscr="subsubsection with optional label"},
    fmta(
      [[\subsubsection<>]],
      {
        c(1, {sn(nil, {t("{"),i(1),t("}")}),sn(nil, {t("{"),i(1),t({"}","\\label{subsubsec:"}),f(space_to_uscore,{1}),i(2),t("}")})})
      }
    )
  ),
  s({trig="par", dscr="paragraph"},
    fmta(
      "\\paragraph{<>}",
      { d(1, get_visual), }
    )
  ),

  s({trig="clp", dscr="clear page"},
    {
      t("\\clearpage")
    },
    {condition = line_begin}
  ),
  s({trig="noi", dscr="no indent"},
    {
      t("\\noindent")
    },
    {condition = line_begin}
  ),
  s({trig="mb", dscr="mini box around text"},
    fmta(
      "\\mbox{<>}",
      { d(1, get_visual), }
    )
  ),

  -- footnotes / endnotes / quotes / references
  s({trig="fn", dscr="foot note"},
    c(1, {sn(nil, fmta(
      "\\footnote{<>}", { d(1, get_visual) }
    )),
      sn(nil, fmta(
        [[
          \footnote{
            <>
          }
        ]], { d(1, get_visual) }
      ))}),
    {condition = in_text}
  ),
  s({trig="todo", dscr="todo - entry into the TODO list"},
    fmta(
      "\\todo{<>}",
      { d(1, get_visual) }
    )
  ),
  s({trig="ind", dscr="entry into the INDEX"},
    c(1, {sn(nil, fmta("\\index{<>}", {i(1)})),
      sn(nil, fmta("<>\\index{<>}", {d(1, get_visual), rep(1)}))})
  ),
  s({trig="ct", dscr="cite a source"},
    fmta(
      "\\cite{<>}",
      { d(1, get_visual) }
    )
  ),
  s({trig="ref", dscr="references"},
    fmta(
      "\\ref{<><>}",
      { i(1,"fig:"), i(2) }
    )
  ),
  s({trig="ere", dscr="reference equations"},
    fmta(
      "\\eqref{eq:<>}",
      { i(1) }
    )
  ),

  -- text commands
  s({trig="e", dscr="emphazise"},
    fmta(
      "\\emph{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_text}
  ),
  s({trig="en", dscr="enquote"},
    fmta(
      "\\enquote{<>}",
      { d(1, get_visual) }
    ),
    {condition = in_text}
  ),
  s({trig="en*", dscr="enquote*"},
    fmta(
      "\\enquote*{<>}",
      { d(1, get_visual) }
    )
  ),
  s({trig="bf", dscr="bold face"},
    fmta(
      "\\textbf{<>}",
      { d(1, get_visual), }
    )
  ),
  s({trig="tt", dscr="text tt"},
    fmta(
      "\\texttt{<>}",
      { d(1, get_visual), }
    )
  ),
  s({trig="__", dscr="text subscript", snippetType="autosnippet", wordTrig=false},
    fmta(
      "\\textsubscript{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_text}
  ),
  s({trig="**", dscr="text superscript"},
    fmta(
      "\\textsuperscript{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_text}
  ),

}
