local M = {}


-- complete list: -- use as required
local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local r = ls.restore_node

-- useful functions
-- get visual function for getting marked text into the snippet
function M.get_visual(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

--for latex context detection
function M.in_math()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

function M.in_text()
  return not M.in_math()
end

function M.in_comment()
  return vim.fn['vimtex#syntax#in_comment']() == 1
end

function M.in_preamble()
  return vim.fn['vimtex#syntax#in_preamble']() == 1
end

function M.in_env(name)
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

function M.in_itemize()
  return M.in_env('itemize')
end

function M.is_in_math(args, parent)
  if M.in_math() then
    return sn(nil, t(""))
  else
    return sn(nil, t("$"))
  end
end

-- functions for custom snippets
function M.space_to_uscore(args, parent, user_args)
  local str = table.concat(args[1])
  return string.gsub(str, "%s+", "_")
end





return M
