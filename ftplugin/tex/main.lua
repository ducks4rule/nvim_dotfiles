local opts = { noremap = true, silent = true }

-- shorten function name
local keymap = vim.api.nvim_set_keymap

-- ============ spell checking ============
-- togle EN with 's'
keymap("n", "<leader>s", ":setlocal spell! spelllang=en_gb<cr> :syntax match Comment /%[^\"]\\+$/ contains=@NoSpell<CR>",opts)
-- togle DE with 'leader sd'
keymap("n", "<leader>sd", ":setlocal spell! spelllang=de<cr> :syntax match Comment /%[^\"]\\+$/ contains=@NoSpell<CR>",opts) -- only one language for cmp spell


-- german keys latex remap
keymap("i", "\"a", "ä", opts)
keymap("i", "\"A", "Ä", opts)
keymap("i", "\"o", "ö", opts)
keymap("i", "\"O", "Ö", opts)
keymap("i", "\"u", "ü", opts)
keymap("i", "\"U", "Ü", opts)
keymap("i", "\"s", "ß", opts)


