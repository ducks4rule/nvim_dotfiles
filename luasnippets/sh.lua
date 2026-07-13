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


return{
  s({trig="bash",snippetType="autosnippet", dscr="first line of bash code"},
    {
      t({"#!/bin/bash",""})
    },
    {condition = line_begin}
  ),
  s({trig="if", dscr="opens if loop"},
    fmta(
      [[
        if [ <> <> <> ]
        then
          <>
        fi
      ]],
      {
        i(1),
        i(2, "-eq"),
        i(3),
        d(4, get_visual)
      }
    ),
    {condition = line_begin}
  ),
}
