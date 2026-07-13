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


return{
  -- import and packages
  s({trig="im", dscr="import package"},
    fmta(
      "import <> as <>",
      { i(1),i(2) }
    ),
    {condition = line_begin}
  ),
  s({trig="fr", dscr="from package import"},
    fmta(
      "from <> import <>",
      { c(1, {i(1), sn(nil, {t("sklearn."),i(1)})}), i(2,"*") }
    ),
    {condition = line_begin}
  ),
  s({trig="Inp", dscr="import numpy as np"},
    {
      t("import numpy as np")
    },
    {condition = line_begin}
  ),
  s({trig="Ipd", dscr="import pandas as pd"},
    {
      t("import pandas as pd")
    },
    {condition = line_begin}
  ),
  s({trig="Iplt", dscr="import matplotlib.pyplot as plt"},
    {
      t("import matplotlib.pyplot as plt")
    },
    {condition = line_begin}
  ),
  s({trig="Ito", dscr="import pytorch"},
    fmta(
      [[
          import torch
          import torch.nn as nn
          <>
      ]],
      {
        c(1, {t(""), t({"import torch.optim as optim", "import torch.utils"}),
                 t({"import torch.optim as optim","import torch.utils","import torch.utils.data","from torch.utils.data import DataLoader"})})
      }
    ),
    {condition = line_begin}
  ),

  -- functions
  s({trig="def", dscr="funtion definition"},
    fmta(
      [[
        def <>(<>):
            <>
            <>
      ]],
      {
        i(1,"function"),
        i(2,"X"),
        c(3, {sn(nil, fmta(
          [[
            """
                <>
                """
                <>
          ]],
          { i(1), i(2) }
        )), t("")}),
        c(4, {sn(nil, {t("return "), i(1)}), t("")})
      }
    ),
    {condition = line_begin}
  ),
  s({trig="if", dscr="if statement", snippetType="autosnippet"},
    fmta(
      [[
        if <>:
            <>
      ]],
      {
        i(1, "False"),
        c(2, {i(1), sn(nil, fmta(
          [[
            <>
            else:
                <>
          ]],
          { i(1), i(2) }
        )), sn(nil, fmta(
          [[
            <>
            elif <>:
                <>
          ]],
          { i(1), i(2, "True"), i(3) }
        ))})
      }
    ),
    {condition = line_begin}
  ),
  s({trig="for", dscr="for loop", snippetType="autosnippet"},
    fmta(
      [[
        for <> in <>:
            <>
      ]],
      { i(1, "i"), i(2, "range(n)"), i(3) }
    ),
    {condition = line_begin}
  ),
  s({trig="try", dscr="try and except statement", snippetType="autosnippet"},
    fmta(
      [[
        try:
            <>
        except:
            <>
      ]],
      { i(1), i(2) }
    ),
    {condition = line_begin}
  ),
  s({trig="class", dscr="define a class"},
    fmta(
      [[
        class <>(<>):
            <>
            def <>(<>):
                <>
      ]],
      {
        i(1, "ClassDef"), i(2,"ClassType"),
        c(3, {sn(nil, fmta(
          [[
            """
                <>
                """
          ]],
          { i(1) }
        )), t("")}),
        i(4,"__init__"),i(5,"self"),
        c(6, {t(""), sn(nil, fmta(
          [[
            """
                <>
                """
                <>
          ]],
          { i(1), i(2) }
        ))}),
      }
    ),
    {condition = line_begin}
  ),

  -- comments
  s({trig="sec", dscr="section for code (comment)"},
    fmta(
      [[
        # ==============================
        # <>
        # ==============================

      ]],
      { i(1) }
    ),
    {condition = line_begin}
  ),
  s({trig="cb", dscr="comment bloc"},
    fmta(
      [[
        """
        <>
        """
      ]],
      { i(1) }
    ),
    {condition = line_begin}
  ),

  -- jupyter notebooks
  s({trig="cc", dscr="new code cell", snippetType="autosnippet"},
    fmta(
      [[
        # %%
        <>

      ]],
      { i(1, "# this is a code cell") }
    ),
    {condition = line_begin}
  ),
  s({trig="md", dscr="new mark down cell", snippetType="autosnippet"},
    fmta(
      [[
        # %% [markdown]
        """
        <>
        """

      ]],
      { i(1, "# this is a markdown cell") }
    ),
    {condition = line_begin}
  ),
}
