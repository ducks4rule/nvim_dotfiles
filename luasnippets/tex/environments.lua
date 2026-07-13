-- local snippet vars
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local helpers = require("user.snippets.snippet_helper_functions")
local get_visual = helpers.get_visual
local in_env = helpers.in_env
local space_to_uscore = helpers.space_to_uscore

local item_valid = function ()
  local val_1 = (helpers.in_itemize() or in_env('description') or in_env('enumerate'))
  local val_2 = line_begin
  return (val_1 and val_2)
end

-- local make_condition = require("luasnip.extras.conditions").make_condition -- turns functions into condition objects





-- =========================================================
-- ==== snippets
-- =========================================================

return{
  -- ======== general environments ========
  -- environments
  s({trig="env", dscr="environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{<>}<>
            <>
        \end{<>}
      ]],
      {
        i(1, "environment name"),
        i(2),
        d(3, get_visual),
        rep(1)
      }
    ),
    {condition = line_begin}
  ),

  -- itemize
  s({trig="ite", dscr="Itemize environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{itemize}
            \item <> <>
        \end{itemize}
      ]],
      {
        d(1, get_visual),
        c(2, {t(""), sn(nil, {t("\\label{"),i(1),t("}")})})
      }
    ),
    {condition = line_begin}
  ),

  -- enumerate
  s({trig="enu", dscr="enumeration environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{enumerate}<>
            \item <> <>
        \end{enumerate}
      ]],
      {
        c(1, {t(""), sn(nil, {t("["), i(1, "label"), t("="), i(2,"\\alph*)"), t("]")})}),
        d(2, get_visual),
        i(3)
      }
    ),
    {condition = line_begin}
  ),

  -- description
  s({trig="des", dscr="description environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{description}<>
            \item [<>] <>
        \end{description}
      ]],
      {
        c(1, {sn(nil, {t("["), i(1, "font=\\normalfont\\itshape"), t("]")}), t("")}),
        i(2, "$(\\implies)$"),
        c(3, {sn(nil, {i(1), t({"","  \\item ["}), i(2, "$(\\impliedby)$"),t("] "),i(3)}), t("")})
      }
    ),
    {condition = line_begin}
  ),

  -- item for list environments
  s({trig = "((%s%s%s%s))itm", dscr="item symbol for list environments",
              wordTrig = false, regTrig = true, snippetType="autosnippet"},
    fmta(
      "\\item <>",
      { c(1, {i(nil), sn(nil, {i(1), t("\\label{"), i(2), t("}")}), sn(nil, fmta(
        "[<>] <>",
        { i(1), i(2) }
      )), sn(nil, fmta(
        "[<>] <>\\label{<>}",
        { i(1), i(2), i(3) }
      ))}) }
    )
  ),

  -- center
  s({trig="cen", dscr="center environment"},
    fmta(
      [[
        \begin{center}
            <>
        \end{center}
      ]],
      { d(1, get_visual) }
    ),
    {condition = line_begin}
  ),

  -- ======== math related ========
  -- inline math
  s({trig ="([^%a])mm", dscr="in line math mode '$ $'",
            regTrig = true, wordTrig = false,
            snippetType="autosnippet"},
    fmta(
      "<>$ <> $",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual)
      }
    )
  ),

  -- display math
  s({trig="dm", dscr="display math", snippetType="autosnippet"},
    fmta(
      [[
        \[
             <>
        \]
      ]],
      { d(1, get_visual) }
    ),
    {condition = line_begin}
  ),

  -- Align environment
  s({trig="ali", dscr="Align environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{align}
            <> &<> <>
        \end{align}
      ]],
      {
        d(1, get_visual),
        i(2),
        c(3,{t(""),
          sn(nil, {
            t({"\\\\",""}), i(1)
          }),
          sn(nil, {
            t("\\\\ \\label{eq:"), i(1), t({"}",""}), i(2)
          })})
      }
    ),
    {condition = line_begin}
  ),

  -- equation environment
  s({trig="eq", dscr="equation environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{equation}<>
            <>
        \end{equation}
      ]],
      {
        c(1, {t(""),
          sn(nil, {
            t("\\label{eq:"), i(1), t("}")
          })}),
        d(2, get_visual),
      }
    ),
    {condition = line_begin}
  ),

  -- ======== theorem environments ========
  -- proof
  s({trig="pf", dscr="proof environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{proof}<>
            <>
        \end{proof}
      ]],
      {
        c(1, {t(""), t("\\hfill")}),
        d(2, get_visual)
      }
    ),
    {condition = line_begin}
  ),

  -- definition
  s({trig="def", dscr="definition environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{mydef}<>
            <>
        \end{mydef}
      ]],
      {
        c(1, {t(""), sn(nil, {t("["), i(1), t("]")}),sn(nil, {
              t("["), i(1), t("]\\label{def:"), i(2), t("}")
        })}),
        d(2, get_visual)
      }
    ),
    {condition = line_begin}
  ),

  -- theorem
  s({trig="thm", dscr="theorem environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{thm}<>
            <>
        \end{thm}
      ]],
      {
        c(1, {t(""), sn(nil, {t("["), i(1), t("]")}), sn(nil, {
              t("["), i(1), t("]\\label{thm:"), i(2), t("}")
        })}),
        d(2, get_visual)
      }
    ),
    {condition = line_begin}
  ),

  -- lemma
  s({trig="lem", dscr="lemma environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{lem}<>
            <>
        \end{lem}
      ]],
      {
        c(1, {t(""), sn(nil, {t("["), i(1), t("]")}), sn(nil, {
              t("["), i(1), t("]\\label{lem:"), i(2), t("}")
        })}),
        d(2, get_visual)
      }
    ),
    {condition = line_begin}
  ),

  -- remark
  s({trig="rmk", dscr="remark environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{remark}
            <>
        \end{remark}
      ]],
      { d(1, get_visual), }
    ),
    {condition = line_begin}
  ),

  -- example
  s({trig="ex", dscr="example environment", snippetType="autosnippet"},
    fmta(
      [[
        \begin{example}
            <>
        \end{example}
      ]],
      { d(1, get_visual), }
    ),
    {condition = line_begin}
  ),

  -- ======== table and floats environments ========
  -- table environment
  s({trig="tab", dscr="table environment"},
    fmta(
      [[
        \begin{table}[<>]
            \centering
            \caption{<>}
            \label{tab:<>}
            <>
        \end{table}
      ]],
      {
        i(1, "t"),
        i(2, "caption"),
        i(3, "label"),
        d(1, get_visual)
      }
    ),
    {condition = line_begin}
  ),

  -- tabular
  s({trig="tabu", dscr="tabular"},
    fmta(
      [[
        \begin{<>}<>\toprule
            <> & <>
            \bottomrule
        \end{<>}
      ]],
      {
        sn(1, {t("tabular"), i(1)}),
        c(2, {sn(nil, {t("{"),i(1, "ll"),t("}")}),
              sn(nil, {t("["),i(1),t("]"),t("{"),i(2, "ll"),t("}")})}),
        i(3),
        c(4, {sn(nil, {
            i(1), t({" \\\\ \\midrule","  "}), i(2), t(" & "), i(3)
          }),t("")}),
        rep(1)
      }
    ),
    {condition = line_begin}
  ),
  s({trig="fig", dscr="figure environment"},
    fmta(
      [[
        \begin{figure}[<>]
            \centering
            <>
        \end{figure}
      ]],
      {
        i(1, "b!"),
        c(2, {
          sn(nil, fmta(
            [[
              \includegraphics[width=<><>]{<>}
                \caption{<>}
                \label{fig:<><>}
            ]],
            {
              i(1, "0.9"), i(2, "\\textwidth"),
              i(3, "filename"),
              i(4, "caption text"),
              f(space_to_uscore, {3}), i(5)
            }
          )),
          sn(nil, fmta(
            [[
              \def\svgwidth{<><>}
                \input{<>.pdf_tex}
                \caption{<>}
                \label{fig:<><>}
            ]],
            {
              i(1, "0.9"), i(2, "\\textwidth"),
              i(3, "svg file name"),
              i(4, "caption text"),
              f(space_to_uscore, {3}),i(5)
            }
          )),
          sn(nil, fmta(
            [[
              <>
                \caption{<>}
                \label{fig:<>}
            ]],
            {
              i(1, "add subfigure here"),
              i(2, "caption text"),
              i(3, "label for fig")
            }
          ))
        })
      }
    ),
    {condition = line_begin}
  ),
  s({trig="wfig", dscr="wrap figure"},
    fmta(
      [[
        \begin{wrapfigure}{<>}{<><>}
            \centering
            \includegraphics[width=<><>]{<>}
            \caption{<>}
            \label{fig:<><>}
        \end{wrapfigure}
      ]],
      {
        i(1, "R"), i(2, "0.4"), i(3, "\\textwidth"),
        i(4, "0.38"), i(5, "\\textwidth"),
        i(6, "filename"),
        i(7, "caption text"),
        f(space_to_uscore, {6}), i(8)
      }
    ),
    {condition = line_begin}
  ),
  s({trig="sfig", dscr="subfigure, use inside a figure environment"},
    fmta(
      [[
        \begin{subfigure}<>
            \includegraphics[width=<>]{<>}
            \caption{<>}
            \label{subfig:<><>}
        \end{subfigure}
      ]],
      {
        c(1, {sn(nil, fmta(
          "{<><>}", { i(1, "0.4"), i(2, "\\textwidth")}
          )),
          sn(nil, fmta(
                "[<>]{<><>}", { i(1), i(2, "0.4"), i(3, "\\textwidth") }
          ))
        }),
        i(2, "\\textwidth"),
        i(3, "subfigure filename"),
        i(4, "caption text"),
        f(space_to_uscore, {3}), i(5)
      }
    ),
    {condition = line_begin}
  ),

}
