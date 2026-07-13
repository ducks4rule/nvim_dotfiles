-- local snippet vars
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local helpers = require("user.snippets.snippet_helper_functions")
local get_visual = helpers.get_visual
local in_math = helpers.in_math
local in_text = helpers.in_text
local is_in_math = helpers.is_in_math

local line_begin = require("luasnip.extras.expand_conditions").line_begin


-- integral functions
-- generate \int_{<>}^{<>}
local int1 = function(args, snip)
    local vars = tonumber(snip.captures[1])
    local nodes = {}
    for j = 1, vars do
	table.insert(nodes, t("\\int_{"))
	table.insert(nodes, r(2*j-1, "lb" .. tostring(j), i(1)))
	table.insert(nodes, t("}^{"))
	table.insert(nodes, r(2*j, "ub" .. tostring(j), i(1)))
	table.insert(nodes, t("} "))
    end
    return sn(nil, nodes)
end

-- generate \dd <>
local int2 = function(args, snip)
    local vars = tonumber(snip.captures[1])
    local nodes = {}
    for j = 1, vars do
	table.insert(nodes, t(" \\diff "))
	table.insert(nodes, r(j, "var" .. tostring(j), i(1)))
    end
    return sn(nil, nodes)
end




local M = {
  -- Formatting
  s({trig="mcl", dscr="eliminate horizontal space '\\mathclap'",snippetType="autosnippet"},
    fmta(
      "\\mathclap{<>}",
      { d(1, get_visual) }
    ),
    {condition = in_math}
  ),

  s({trig="sms", dscr="eliminate vertical space '\\smash'"},
    fmta(
      "\\smash{<>}",
      { d(1, get_visual) }
    ),
    {condition = in_math}
  ),

  s({trig="subs", dscr="'\\substack'"},
    fmta(
      "\\substack{<> \\\\ <>}",
      {
        d(1, get_visual),
        i(2)
      }
    ),
    {condition = in_math}
  ),
  s({trig="ttt", dscr="text in mathmode", snippetType="autosnippet"},
    fmta(
      "\\text{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_math}
  ),


  -- Graphics
  s({trig="qd",snippetType="autosnippet", dscr="'\\quad'"},
    {
      t("\\quad")
    },
    {condition = in_math}
  ),

  s({trig="qqd",snippetType="autosnippet", dscr="'\\qquad'"},
    {
      t("\\qquad")
    },
    {condition = in_math}
  ),


  -- Environments in math mode
  s({trig="cas", dscr="cases environment"},
    fmta(
      [[
        \begin{cases}
            <> & <> \\
            <> & <>
        \end{cases}
      ]],
      {
        d(1, get_visual),
        i(2),
        i(3),
        i(4)
      }
    ),
    {condition = in_math and line_begin}
  ),

  s({trig="split", dscr="split environment"},
    fmta(
      [[
        \begin{split}
            <> &<> \\
            <>
        \end{split}
      ]],
      {
        d(1, get_visual),
        i(2),
        i(3)
      }
    ),
    {condition = in_math and line_begin}
  ),


  -- Limmiters and delimiters
  s({trig="lr", dscr="'\\left% \\right%"},
    fmta(
      "\\left<> <> \\right<>",
      {
        i(1, "("),
        d(2, get_visual),
        i(3, ")")
      }
    ),
    {condition = in_math}
  ),

  s({trig="lr(", dscr="'\\left( \\right)'", snippetType="autosnippet"},
    fmta(
      "\\left( <> \\right",
      { d(1, get_visual) }
    ),
    {condition = in_math}
  ),

  s({trig="lr{", dscr="'\\left{ \\right}'", snippetType="autosnippet"},
    fmta(
      "\\left\\{ <> \\right",
      { d(1, get_visual) }
    ),
    {condition = in_math}
  ),

  s({trig="lr|", dscr="'\\left| \\right|'", snippetType="autosnippet"},
    fmta(
      "\\left| <> \\right|",
      { d(1, get_visual) }
    ),
    {condition = in_math}
  ),

  s({trig="lr[", dscr="'\\left[ \\right]'", snippetType="autosnippet"},
    fmta(
      "\\left[ <> \\right",
      { d(1, get_visual) }
    ),
    {condition = in_math}
  ),

  s({trig="lra", dscr="'\\left< \\right>'", snippetType="autosnippet"},
    fmta(
      "\\left\\langle <> \\right\\rangle",
      { d(1, get_visual) }
    ),
    {condition = in_math}
  ),

  -- General symbols
  s({trig="FA",snippetType="autosnippet", dscr="for all", wordTrig=false},
    {
      t("\\forall")
    },
    {condition = in_math}
  ),
  s({trig="EE", dscr="exists", wordTrig=false},
    {
      t("\\exists")
    },
    {condition = in_math}
  ),
  s({trig="oo",snippetType="autosnippet", dscr="infinity symbol", wordTrig=false},
    {
      t("\\infty")
    },
    {condition = in_math}
  ),
  s({trig="...",snippetType="autosnippet", dscr="...", wordTrig=false},
    {
      t("\\ldots")
    },
    {condition = in_math}
  ),
  s({trig="!>",snippetType="autosnippet", dscr="maps to", wordTrig=false},
    {
      c(1, {t("\\mapsto"), t("\\longmapsto")})
    },
    {condition = in_math}
  ),
  s({trig="<->",snippetType="autosnippet", dscr="left-right arrow", wordTrig=false},
    {
      d(1, is_in_math), t("\\leftrightarrow"), rep(1)
    }
  ),
  s({trig="->", dscr="right arrow", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\rightarrow"), rep(1)
    }
  ),
  s({trig="<-", dscr="left arrow"},
    {
      d(1, is_in_math), t("\\leftarrow"), rep(1)
    }
  ),
  s({trig=">>",snippetType="autosnippet", dscr="implies", wordTrig=false},
    {
      d(1, is_in_math), t("\\implies"), rep(1)
    }
  ),
  s({trig="<<",snippetType="autosnippet", dscr="implied by", wordTrig=false},
    {
      d(1, is_in_math), t("\\impliedby"), rep(1)
    }
  ),
  s({trig="iff", dscr="if and only if", snippetType="autosnippet", wordTrig=false},
    {
      t("\\iff")
    },
    {condition = in_math, priority = 500}
  ),
  s({trig="||",snippetType="autosnippet", dscr="mid line", wordTrig=false},
    {
      t("\\mid")
    },
    {condition = in_math}
  ),
  s({trig="n||",snippetType="autosnippet", dscr="not mid",wordTrig=false},
    {
      t("\\nmid")
    },
    {condition = in_math}
  ),
  s({trig="n=", dscr="not equal",wordTrig=false},
    {
      t("\\neq")
    },
    {condition = in_math}
  ),
  s({trig="<=",snippetType="autosnippet", dscr="les or equal than", wordTrig=false},
    {
      t("\\le")
    },
    {condition = in_math}
  ),
  s({trig=">=",snippetType="autosnippet", dscr="greater or equal than", wordTrig=false},
    {
      t("\\ge")
    },
    {condition = in_math}
  ),
  s({trig="~=",snippetType="autosnippet", dscr="'\\cong' isomorph"},
    {
      t("\\cong")
    },
    {condition = in_math}
  ),
  s({trig="==",snippetType="autosnippet", dscr="equivalent"},
    {
      t("\\equiv")
    },
    {condition = in_math}
  ),
  s({trig="~~",snippetType="autosnippet", dscr="approximately"},
    {
      t("\\approx")
    },
    {condition = in_math}
  ),
  s({trig="tms",snippetType="autosnippet", dscr="times 'x'"},
    {
      t("\\times")
    },
    {condition = in_math}
  ),
  s({trig="cd", dscr="cdot", snippetType="autosnippet"},
    {
      t("\\cdot")
    },
    {condition = in_math}
  ),
  s({trig="nin", dscr="not in symbol", wordTrig=false, snippetType="autosnippet"},
    {
      t("\\notin")
    },
    {condition = in_math}
  ),
  s({trig="s{", dscr="set braces", wordTrig=false, snippetType="autosnippet"},
    fmta(
      "\\{ <>\\",
      { d(1, get_visual) }
    ),
    {condition = in_math}
  ),
  s({trig="CC", dscr="subset"},
    {
      t("\\subset")
    },
    {condition = in_math}
  ),
  s({trig="nCC", dscr="subset not equal"},
    {
      t("\\subsetneq")
    },
    {condition = in_math}
  ),
  s({trig="pCC", dscr="super set"},
    {
      t("\\supset")
    },
    {condition = in_math}
  ),
  s({trig="npCC", dscr="super set not equal"},
    {
      t("\\supsetneq")
    },
    {condition = in_math}
  ),
  s({trig="s-", dscr="set minus"},
    {
      t("\\setminus")
    },
    {condition = in_math}
  ),
  s({trig="uu", dscr="union symbol", snippetType="autosnippet"},
    {
      t("\\cup")
    },
    {condition = in_math}
  ),
  s({trig="UU", dscr="big union symbol", snippetType="autosnippet"},
    fmta(
      "\\bigcup<>",
      { c(1, {t(""), sn(nil, {t("_{"),i(1,"n\\ge 0"),t("}")}),
        sn(nil, {t("_{"),i(1,"n=0"),t("}^{"),i(2,"\\infty"),t("}")})}) }
    ),
    {condition = in_math}
  ),
  s({trig="nn", dscr="intersection symbol", snippetType="autosnippet"},
    {
      t("\\cap")
    },
    {condition = in_math}
  ),
  s({trig="NN", dscr="big intersection symbol", snippetType="autosnippet"},
    fmta(
      "\\bigcap<>",
      { c(1, {t(""), sn(nil, {t("_{"),i(1,"n\\ge 0"),t("}")}),
        sn(nil, {t("_{"),i(1,"n=0"),t("}^{"),i(2,"\\infty"),t("}")})}) }
    ),
    {condition = in_math}
  ),

  -- Scripts
  s({trig="mbb", dscr="mathbb", snippetType="autosnippet"},
    fmta(
      "\\mathbb{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_math}
  ),
  s({trig="mca", dscr="mathcal", snippetType="autosnippet"},
    fmta(
      "\\mathcal{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_math}
  ),
  s({trig="mrm", dscr="mathrm", snippetType="autosnippet"},
    fmta(
      "\\mathrm{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_math}
  ),
  s({trig="bs", dscr="boldsymbol", snippetType="autosnippet"},
    fmta(
      "\\boldsymbol{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_math}
  ),
  s({trig="til", dscr="tilde over letter", snippetType="autosnippet"},
    fmta(
      "\\widetilde{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_math}
  ),
  s({trig="bar", dscr="bar over symbol"},
    fmta(
      "\\overline{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_math}
  ),
  s({trig="hat", dscr="hat over symbol"},
    fmta(
      "\\widehat{<>}",
      { d(1, get_visual), }
    ),
    {condition = in_math}
  ),
  s({trig="os", dscr="overset a symbol with text"},
    fmta(
      "\\overset{<>}{<>}",
      { i(1,"text"), i(2,"=") }
    ),
    {condition = in_math}
  ),
  s({trig="us", dscr="underset a symbol with text"},
    fmta(
      "\\underset{<>}{<>}",
      { i(1,"text"), i(2,"=") }
    ),
    {condition = in_math}
  ),
  s({trig="ubr", dscr="underbrace"},
    fmta(
      "\\underbrace{<>}_{<>}",
      { d(1, get_visual), i(2, "n") }
    ),
    {condition = in_math}
  ),
  s({trig="obr", dscr="overbrace"},
    fmta(
      "\\overbrace{<>}^{<>}",
      { d(1, get_visual), i(2, "n") }
    ),
    {condition = in_math}
  ),

  -- Set theory and symbols
  s({trig="s0", dscr="empty set"},
    {
      t("\\emptyset")
    },
    {condition = in_math}
  ),
  s({trig="N", dscr="Natural numbers"},
    {
      d(1, is_in_math), t("\\mathbb{N}"), rep(1)
    }
  ),
  s({trig="Z", dscr="Whole numbers"},
    {
      d(1, is_in_math), t("\\mathbb{Z}"), rep(1)
    }
  ),
  s({trig="Q", dscr="Rational numbers"},
    {
      d(1, is_in_math), t("\\mathbb{Q}"), rep(1)
    }
  ),
  s({trig="F", dscr="Field"},
    {
      d(1, is_in_math), t("\\mathbb{F}"), rep(1)
    }
  ),
  s({trig="D", dscr="Unit disc"},
    {
      d(1, is_in_math), t("\\mathbb{D}"), rep(1)
    }
  ),
  s({trig="S", dscr="Unit sphere"},
    {
      d(1, is_in_math), t("\\mathbb{S}"), rep(1)
    }
  ),
  s({trig="R", dscr="Real numbers"},
    {
      d(1, is_in_math),t("\\mathbb{R}"), rep(1)
    }
  ),
  s({trig="Rn", dscr="Real numbers '^n'"},
    fmta(
      "<>\\mathbb{R}^{<>}<>",
      { d(1, is_in_math),i(2, "n"),rep(1) }
    )
  ),
  s({trig="B", dscr="Ball"},
    fmta(
      "<>B(<>,<>)<>",
      { d(1, is_in_math),i(2, "0"), i(3, "1"), rep(1) }
    )
  ),


  -- Logic
  s({trig="pv", dscr="proven by", snippetType="autosnippet", wordTrig=false},
    {
      t("\\vdash")
    },
    {condition = in_math}
  ),

  -- operators and computation
  -- power and subscript
  s({trig="**", dscr="to the power of", snippetType="autosnippet", wordTrig=false},
    fmta(
      "^{<>}",
      { d(1, get_visual) }
    ),
    {condition = in_math}
  ),
  s({trig="__", dscr="subscript in math mode", snippetType="autosnippet", wordTrig=false},
    fmta(
      "_{<>}",
      { d(1, get_visual) }
    ),
    {condition = in_math}
  ),
  s({trig = "([%a%)%]%}])00", dscr="zero subscript",
              wordTrig = false, regTrig = true, snippetType="autosnippet"},
    fmta(
      "<>_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("0")
      }
    ),
    {condition = in_math}
  ),
  s({trig="iv", dscr="inverse operator", snippetType="autosnippet", wordTrig=false},
    {
      t("^{-1}")
    },
    {condition = in_math}
  ),
  s({trig="p2", dscr="to the power of two", snippetType="autosnippet", wordTrig=false},
    {
      t("^{2}")
    },
    {condition = in_math}
  ),
  s({trig="pn", dscr="to the power of n", snippetType="autosnippet", wordTrig=false},
    {
      t("^{n}")
    },
    {condition = in_math}
  ),
  s({trig="pp", dscr="to the power of p", snippetType="autosnippet", wordTrig=false},
    {
      t("^{p}")
    },
    {condition = in_math}
  ),
  s({trig="pc", dscr="complement", snippetType="autosnippet", wordTrig=false},
    {
      t("^{c}")
    },
    {condition = in_math}
  ),
  s({trig="pal", dscr="to the power of '\\alpha' -- Multiindex", snippetType="autosnippet"},
    {
      t("^\\alpha")
    },
    {condition = in_math}
  ),
  s({trig="pt", dscr="transpose", snippetType="autosnippet", wordTrig=false},
    {
      t("^{T}")
    },
    {condition = in_math}
  ),
  s({trig="p*", dscr="adjoint/dual"},
    {
      t("^{*}")
    },
    {condition = in_math}
  ),
  -- s({trig = "([^%a])ff", dscr="fraction",
  s({trig = "ff", dscr="fraction",
              snippetType="autosnippet"},
    fmta(
      "<>{<>}",
      {
        c(1, {sn(nil, {t("\\frac{"), i(1), t("}")}), sn(nil, {t("\\dfrac{"), i(1), t("}")})}),
        i(2)
      }
    ),
    {condition = in_math}
  ),
  s({trig = "([^%s]+)ff", dscr="fraction",
              wordTrig = false, regTrig = true, snippetType="autosnippet"},
    fmta(
      "\\frac{<>}{<>}",
      {
        f( function(_,snip)
          return snip.captures[1]
        end ),
        i(1)
      }
    ),
    {condition = in_math}
  ),
  -- operators
  s({trig="sqr", dscr="squareroot function", snippetType="autosnippet"},
    {
      t("\\sqrt{"),d(1, get_visual),t("}")
    },
    {condition = in_math}
  ),
  s({trig="del", dscr="partial differentiation operator", snippetType="autosnippet"},
    {
      c(1, {t("\\partial"), sn(nil, fmta(
        "\\frac{\\partial <>}{\\partial <>}",
        { i(1, "u"), i(2, "x") }
      ))})
    },
    {condition = in_math}
  ),


  -- functions
  s({trig="fu", dscr="function definition in one line - optional explicit map"},
    fmta(
      "<><>: <>\\to <><>",
      {
        d(1, is_in_math),
        i(2, "f"),
        i(3, "X"),
        c(4, {i(nil,"Y"), sn(nil, fmta(
          "<>,\\ <> \\mapsto <>",
          { i(1,"Y"), i(2, "x"), i(3, "f(x)") }
        ))}),
        rep(1)
      }
    )
  ),
  s({trig="bfun", dscr="function definition in two lines"},
    fmta(
      [[
        \begin{align*}
          <> : <> &\longrightarrow <> \\
               <> &\longmapsto <>
        \end{align*}
      ]],
      {
        i(1, "f"),
        i(2, "X"),
        i(3, "Y"),
        i(4, "x"),
        i(5, "f(x)")
      }
    ),
    {condition = line_begin}
  ),

  -- Analysis
  s({trig="int", dscr="integral", snippetType="autosnippet"},
    fmta(
      "int_{<>} <>",
      {
        c(1, {sn(nil, {i(1, ""),t("}^{"),i(2)}), i(nil, "")}),
        c(2, {sn(nil, {i(1, ""), t(" \\diff "), i(2, "x")}), r(nil, "")})
      }
    ),
    {condition = in_math}
  ),
  s({trig = "([%d])int", dscr="iterated integral",
              wordTrig = false, regTrig = true, snippetType="autosnippet"},
    fmta(
      [[
        <> <> <>
      ]],
      {
        c(1, { sn(nil, fmta([[
               \<><>nt_{<>}
        ]],
          {
            c(1, { t(""), t("o") }),
            f(function (_, parent, snip)
                local inum = tonumber(parent.parent.captures[1])
                local res = string.rep("i",inum)
                return res
            end),
            i(2)
          })),
          d(nil, int1)
        }),
        i(2),
        d(3, int2)
      }
    ),
    {condition = in_math}
  ),
  s({trig="sum", dscr="sum"}, --snippetType="autosnippet"},
    fmta(
      "\\sum_{<>} <>",
      {
        c(1, {
          i(nil, "k\\ge 0"),
          sn(nil, {i(1, "k=1"),t("}^{"),i(2,"\\infty")}),
        }),
        i(2)
      }
    ),
    {condition = in_math}
  ),
  s({trig="pro", dscr="produkt"},
    fmta(
      "\\prod_{<>} <>",
      {
        c(1, {
          i(nil, "k\\ge 0"),
          sn(nil, {i(1, "k=1"),t("}^{"),i(2,"\\infty")}),
        }),
        i(2)
      }
    ),
    {condition = in_math}
  ),

  -- Linear Algebra
  s({trig="fs", dscr="finite sequence x_1,...,x_n"},
    fmta(
      "<>_1,\\ldots, <>_{<>}",
      { i(1,"x"),rep(1), i(2,"n") }
    ),
    {condition = in_math}
  ),
  s({trig="ft", dscr="from ... to"},
    fmta(
      "<>, \\ldots, <>",
      {
        c(1, {i(nil, "1"), sn(nil, {i(1, "1"), t(", "), i(2, "2")})}),
        i(2, "n")
      }
    ),
    {condition = in_math}
  ),
  s({trig="es", dscr="expanded series"},
    fmta(
      "<>_<> <> \\dots <> <>_<>",
      { i(1, "a"), i(2, "1"), i(3, "+"), rep(3), rep(1), i(4, "n") }
    ),
    {condition = in_math}
  ),

  -- PDEs
  s({trig="lap", dscr="Laplace tranformation"},
    fmta(
      "\\mathcal{L}<>\\}",
      { c(1, {sn(nil, {t("\\{"), i(1, "f(t)")}), sn(nil, {t("^{-1}\\{"),i(1, "F(s)")})}) }
    ),
    {condition = in_math}
  ),
}

-- automatic snippet creation
local create_mult_snippets = function(trigger, snippet, opts)
    opts = opts or {}
    if not trigger.trig then
        error("context doesn't include a `trig` key which is mandatory", 2)
    end
    return s(trigger, snippet, opts)
end

local keys_for_snippets = {
  "to", "not", "sim", "lim",
  "spa", "ker", "dim", "ord", "gcd", "kgV", "deg", "det",
  "min", "max", "sup", "mod", "argmax", "argmin",
  "sin", "cos", "tan", "cot", "csc", "ln", "log", "exp", "star", "perp",
  "prec", "land", "lor", "neg", "in", "mid"
}
local keys_for_snippets2 = {
  "sin", "cos", "tan", "cot", "csc", "sec"
}
local self_trig_snippet = function (key)
  return t("\\" .. key)
end

local self_trig_snippets = {}
for _, v in ipairs(keys_for_snippets) do
	table.insert(self_trig_snippets, create_mult_snippets({ trig = v, dscr=v, snippetType="autosnippet" }, self_trig_snippet(v), { condition = in_math }))
end
-- prepend 'arc'
for _, v in ipairs(keys_for_snippets2) do
	table.insert(self_trig_snippets, create_mult_snippets({ trig = "a" .. v, dscr=v, snippetType="autosnippet" }, self_trig_snippet("arc" .. v), { condition = in_math }))
end
vim.list_extend(M, self_trig_snippets)


return M
