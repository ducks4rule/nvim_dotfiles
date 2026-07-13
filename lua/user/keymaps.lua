local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- shorten function name
local keymap = vim.api.nvim_set_keymap


-- remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.mapllocalleader = " "


-- Modes
--  normal_mode = "n"
--  insert_mode = "i"
--  visual_mode = "v"
--  visual_block_mode = "x"
--  term_mode = "t"
--  command_mode = "c"


-- Normal --
-- better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- leader commands
keymap("n", "<leader>e", ":Lex 30<cr>", opts)                   -- toggles editor
keymap("n", "<leader>ff", ":Format<cr>", opts)                  -- Null-ls formatting
keymap("n", "<leader>gg", ":lua _LAZYGIT_TOGGLE()<cr>", opts)   -- toggle lazy git in term
keymap("n", "<leader>ra", ":lua _RANGER_TOGGLE()<cr>",opts)     -- toggle ranger in term


-- resize with arrows
keymap("n", "<C-Down>", ":resize +2<cr>", opts)
keymap("n", "<C-UP>", ":resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)

-- navigate buffers
keymap("n", "<S-l>", ":bnext<cr>", opts)
keymap("n", "<S-h>", ":bprevious<cr>", opts)

-- Luasnip -- refresh snippets
vim.keymap.set('n', '<Leader>L', '<Cmd>lua require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/luasnippets/"})<CR>')

-- for 'IncRename' - easy renaming with lsp
vim.keymap.set("n", "<leader>rr", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true }) -- insetad of the function jus ":IncRename "


-- Telescope fuzy finder
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = true }))<cr>", opts) -- find files
keymap("n", "<leader>t", "<cmd>Telescope live_grep<cr>", opts) -- cycle through buffer, find text



-- Insert --




-- Visual --
-- stay in indent mode ===== test
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- keep the yanked text in the current register
keymap("v", "p", '"_dP', opts)





-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
