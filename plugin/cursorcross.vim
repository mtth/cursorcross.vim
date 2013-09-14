" plugin/cursorcross.vim

if (exists('g:cursorcross_disable') && g:cursorcross_disable) || v:version < 704 || &compatible
  finish
endif

if !exists('g:cursorcross_dynamic')
  let g:cursorcross_dynamic = 'clw'
endif
if !exists('g:cursorcross_exceptions')
  let g:cursorcross_exceptions = []
endif
if !exists('g:cursorcross_mappings')
  let g:cursorcross_mappings = 1
endif

augroup cursorcross
  autocmd!
  autocmd BufEnter * silent call cursorcross#on_enter()
  autocmd FileType * silent call cursorcross#on_enter()
  autocmd InsertEnter * silent call cursorcross#on_insert('enter')
  autocmd InsertLeave * silent call cursorcross#on_insert('leave')
  autocmd InsertCharPre * silent call cursorcross#on_char_insert()
  autocmd WinEnter * silent call cursorcross#on_enter()
  autocmd WinLeave * silent call cursorcross#on_leave()
augroup END

inoremap <expr> <cr> cursorcross#on_enter_insert()
inoremap <expr> <bs> cursorcross#on_backspace()

if g:cursorcross_mappings
  noremap - :set cursorline!<cr>
  nnoremap \| :set cursorcolumn!<cr>
  xnoremap \| <esc>:set cursorcolumn!<cr>gv
endif
