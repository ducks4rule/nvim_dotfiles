-- local snippet vars
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local helpers = require("user.snippets.snippet_helper_functions")
local in_math = helpers.in_math
local is_in_math = helpers.is_in_math


return{
  s({trig=";N", dscr="\\nabla", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\nabla"), rep(1)
    }
  ),
  s({trig=";a", dscr="\\alpha", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\alpha"), rep(1)
    }
  ),
  s({trig=";b", dscr="\\beta", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\beta"), rep(1)
    }
  ),
  s({trig=";g", dscr="\\gamma", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\gamma"), rep(1)
    }
  ),
  s({trig=";G", dscr="\\Gamma", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\Gamma"), rep(1)
    }
  ),
  s({trig=";d", dscr="\\delta", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\delta"), rep(1)
    }
  ),
  s({trig=";D", dscr="\\Delta", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\Delta"), rep(1)
    }
  ),
  s({trig=";ve", dscr="\\epsilon", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\epsilon"), rep(1)
    }
  ),
  s({trig=";e", dscr="\\varepsilon", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\varepsilon"), rep(1)
    }
  ),
  s({trig=";z", dscr="\\zeta", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\zeta"), rep(1)
    }
  ),
  -- ';e' is taken for '\epsilon' => ';h' because '\Eta' = 'H'
  s({trig=";h", dscr="\\eta", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\eta"), rep(1)
    }
  ),
  -- ';t' and ';T' are take by '\tau' => ';u'
  s({trig=";u", dscr="\\theta", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\theta"), rep(1)
    }
  ),
  s({trig=";vu", dscr="\\vartheta", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\vartheta"), rep(1)
    }
  ),
  s({trig=";U", dscr="\\Theta", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\Theta"), rep(1)
    }
  ),
  s({trig=";k", dscr="\\kappa", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\kappa"), rep(1)
    }
  ),
  s({trig=";l", dscr="\\lambda", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\lambda"), rep(1)
    }
  ),
  s({trig=";L", dscr="\\Lambda", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\Lambda"), rep(1)
    }
  ),
  s({trig=";m", dscr="\\mu", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\mu"), rep(1)
    }
  ),
  s({trig=";n", dscr="\\nu", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\nu"), rep(1)
    }
  ),
  s({trig=";x", dscr="\\xi", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\xi"), rep(1)
    }
  ),
  s({trig=";X", dscr="\\Xi", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\Xi"), rep(1)
    }
  ),
  -- ';p', ';P' are taken by '\psi' => ';3' and ';#'
  s({trig=";3", dscr="\\pi", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\pi"), rep(1)
    }
  ),
  s({trig=";#", dscr="\\Pi", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\Pi"), rep(1)
    }
  ),
  s({trig=";r", dscr="\\rho", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\rho"), rep(1)
    }
  ),
  s({trig=";s", dscr="\\sigma", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\sigma"), rep(1)
    }
  ),
  s({trig=";S", dscr="\\Sigma", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\Sigma"), rep(1)
    }
  ),
  s({trig=";t", dscr="\\tau", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\tau"), rep(1)
    }
  ),
  -- ';p' is taken for '\psi' => ';f' and ';F'
  s({trig=";vf", dscr="\\phi", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\phi"), rep(1)
    }
  ),
  s({trig=";f", dscr="\\varphi", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\varphi"), rep(1)
    }
  ),
  s({trig=";F", dscr="\\Phi", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\Phi"), rep(1)
    }
  ),
  s({trig=";c", dscr="\\chi", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\chi"), rep(1)
    }
  ),
  s({trig=";p", dscr="\\psi", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\psi"), rep(1)
    }
  ),
  s({trig=";P", dscr="\\Psi", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\Psi"), rep(1)
    }
  ),
  s({trig=";o", dscr="\\omega", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\omega"), rep(1)
    }
  ),
  s({trig=";O", dscr="\\Omega", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\Omega"), rep(1)
    }
  ),
  s({trig=";j", dscr="\\iota", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\iota"), rep(1)
    }
  ),
  s({trig=";i", dscr="\\imath", snippetType="autosnippet", wordTrig=false},
    {
      d(1, is_in_math), t("\\imath"), rep(1)
    }
  ),
  s({trig="lll", dscr="\\ell", wordTrig=false},
    {
      d(1, is_in_math), t("\\ell"), rep(1)
    }
  ),

}
