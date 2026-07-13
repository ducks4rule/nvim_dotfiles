vim.opt_local.formatoptions:append("ro")
vim.opt_local.comments = "b:- [ ],b:- [x],b:-,b:*,b:+,b:>,n:>"
vim.opt_local.formatlistpat = [[^\s*\(\d\+[.\)]\|[-*+]\)\s\+]]

-- autolist keymaps
vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", { buffer = 0 })
vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>", { buffer = 0 })
vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", { buffer = 0 })
vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>", { buffer = 0 })
vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>", { buffer = 0 })
vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>", { buffer = 0 })
vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>", { buffer = 0 })

-- tab/shift-tab: cmp > luasnip > autolist
vim.keymap.set("i", "<Tab>", function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expandable() then
    luasnip.expand()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    vim.cmd("AutolistTab")
  end
end, { buffer = 0 })

vim.keymap.set("i", "<S-Tab>", function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    vim.cmd("AutolistShiftTab")
  end
end, { buffer = 0 })
