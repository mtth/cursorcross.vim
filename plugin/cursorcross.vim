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


if g:cursorcross_mappings
  nnoremap <silent> + :call cursorcross#toggle_dynamic_mode()<cr>
  noremap - :set cursorline!<cr>
  nnoremap \| :set cursorcolumn!<cr>
  vnoremap \| <esc>:set cursorcolumn!<cr>gv
endif
