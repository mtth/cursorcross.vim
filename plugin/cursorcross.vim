" plugin/cursorcross.vim


if (exists('g:cursorcross_disable') && g:cursorcross_disable) || &compatible
  finish
endif

if !exists('g:cursorcross_dynamic')
  let g:cursorcross_dynamic = 0
endif
if !exists('g:cursorcross_exceptions')
  let g:cursorcross_exceptions = []
endif
if !exists('g:cursorcross_mappings')
  let g:cursorcross_mappings = 1
endif

command! -bang -nargs=0 CursorcrossToggle call cursorcross#toggle_dynamic_mode()
command! -nargs=0 CursorcrossRestore call cursorcross#on_enter()

augroup cursorcross
  autocmd!
  autocmd BufEnter * silent call cursorcross#on_enter()
  autocmd FileType * silent call cursorcross#on_enter()
  autocmd InsertEnter * silent call cursorcross#on_insert('enter')
  autocmd InsertLeave * silent call cursorcross#on_insert('leave')
  autocmd WinEnter * silent call cursorcross#on_enter()
  autocmd WinLeave * silent call cursorcross#on_leave()
augroup END

if g:cursorcross_mappings
  nnoremap <silent> + :call cursorcross#toggle_dynamic_mode()<cr>
  noremap - :set cursorline!<cr>
  nnoremap \| :set cursorcolumn!<cr>
  vnoremap \| <esc>:set cursorcolumn!<cr>gv
endif
