local opts = { noremap = true, silent = true }
local keymap_buf = vim.api.nvim_buf_set_keymap

-- spell toggle
keymap_buf(0, "n", "<leader>s", ":setlocal spell! spelllang=en_gb<cr>", opts)
keymap_buf(0, "n", "<leader>sd", ":setlocal spell! spelllang=de<cr>", opts)

-- markdown preview
keymap_buf(0, "n", "mv", ":MarkdownPreview<cr>", opts)
