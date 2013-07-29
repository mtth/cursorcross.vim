" plugin/cursorcross.vim

if (exists('g:cursorcross_disable') && g:cursorcross_disable) || &cp
  finish
endif

if !exists('g:cursorcross_dynamic')
  let g:cursorcross_dynamic = 0
endif
if !exists('g:cursorcross_debug')
  let g:cursorcross_debug = 0
endif
if !exists('g:cursorcross_mappings')
  let g:cursorcross_mappings = 1
endif
if !exists('g:cursorcross_exceptions')
  let g:cursorcross_exceptions = []
endif


augroup cursorgroup
  autocmd!
  autocmd BufEnter * silent call cursorcross#on_enter()
  autocmd FileType * silent call cursorcross#on_enter()
  autocmd InsertEnter * silent call cursorcross#on_insert('enter')
  autocmd InsertLeave * silent call cursorcross#on_insert('leave')
  autocmd WinEnter * silent call cursorcross#on_enter()
  autocmd WinLeave * silent call cursorcross#on_leave()
augroup END


command! -bang -nargs=0 CursorcrossDynamicToggle call cursorcross#toggle_dynamic_mode()
command! -nargs=0 CursorcrossRestore call cursorcross#on_enter()


if g:cursorcross_mappings
  nnoremap <silent> + :call cursorcross#toggle_dynamic_mode()<cr>
  noremap - :set cursorline!<cr>
  nnoremap \| :set cursorcolumn!<cr>
  vnoremap \| <esc>:set cursorcolumn!<cr>gv
endif
