local opts = { noremap = true, silent = true }

-- shorten function name
local keymap_buf = vim.api.nvim_buf_set_keymap
-- compile python
-- vim.cmd [[nnoremap <buffer> <F9> :w<CR>:vert ter python3 "%"<CR>]]

-- keymap_buf(0,"n", "py", ":w<CR>:exec '!python3' shellescape(@%, 1)<CR>", opts)
keymap_buf(0,"i", "<F9>", "<esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>", opts)
keymap_buf(0,"n", "<F9>", ":w<CR>:vert ter python3 \"%\"<CR>", opts)


local function run_curr_python_file()
    -- Get file name in the current buffer
    local file_name = vim.api.nvim_buf_get_name(0)

    -- Get terminal codes for running python file
    -- ("i" to enter insert before typing rest of the command)
    local py_cmd = vim.api.nvim_replace_termcodes("ipython \"" .. file_name .. "\"<cr>", true, false, true)

    -- Check if terminal is already open
    -- If so, close it
    local term_buf = vim.fn.bufnr("term://*")
    if term_buf ~= -1 then
        -- Close the terminal buffer
        vim.api.nvim_buf_delete(term_buf, { force = true })
    end

    -- Determine terminal window split and launch terminal
    local percent_of_win = 0.25
    local curr_win_height = vim.api.nvim_win_get_height(0) -- Current window height
    local term_height = math.floor(curr_win_height * percent_of_win) -- Terminal height
    vim.cmd(":w") -- Save current buffer
    vim.cmd(":below " .. term_height .. "split | term") -- Launch terminal (horizontal split)

    -- Press keys to run python command on current file
    vim.api.nvim_feedkeys(py_cmd, "t", false)
end

vim.keymap.set({'n'}, 'py', '', {
    desc = "Run .py file via Neovim built-in terminal",
    callback = run_curr_python_file
})
