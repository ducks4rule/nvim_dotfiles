local status_ok, vimtex = pcall(require, "vimtex")
if not status_ok then
  return
end


-- ================= return focuts to vim after forward search ==================
-- Get Vim's window ID for switching focus from Zathura to Vim using xdotool.
-- Only set this variable once for the current Vim instance.
-- first gives window manager time to recognize focus moved to zathura (200ms)
-- second refocusses vim and redraws the screen
vim.cmd [[
    if !exists("g:vim_window_id")
      let g:vim_window_id = system("xdotool getactivewindow")
    endif

    function! s:TexFocusVim() abort
      sleep 200m

      silent execute "!xdotool windowfocus " . expand(g:vim_window_id)
      redraw!
    endfunction

    augroup vimtex_event_focus
      au!
      au User VimtexEventView call s:TexFocusVim()
    augroup END
]]
