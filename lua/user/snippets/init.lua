local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  return
end

local types = require "luasnip.util.types"

-- basic config
ls.config.set_config{
  -- remember last snippet, even after moving out, can jump back in
  history = true,

  -- dynamical snippets uptdate faster
  updateevents = "TextChanged, TextChangedI",

  -- Autosnippets
  enable_autosnippets = true,

  -- enable visual mode
  store_selection_keys = "<Tab>",
}

-- Keymap for toggling choices
vim.keymap.set("i", "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- reload snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/user/snippets")



require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/luasnippets/"})
-- require("user.snippets.supercollider")
