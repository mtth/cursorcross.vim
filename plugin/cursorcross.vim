" Cursorcross:
"
" Dynamic cursorcolumn and cursorline updates.


" Options:

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
  let g:cursorcross_mappings = 0
endif

" Initialization:

if g:cursorcross_dynamic
  set cursorline
  let s:cursorcross = 1
else
  let s:cursorcross = 0
endif


" Functions:

function! s:toggle_cursorcross(...)
  if a:0
    let cursorcross_save = s:cursorcross
    let s:cursorcross = a:1
  else
    if exists('cursorcross_save')
      let s:cursorcross = cursorcross_save
      unlet cursorcross_save
    else
      let s:cursorcross = !s:cursorcross
    endif
  endif
  if s:cursorcross
    set cursorline
    set nocursorcolumn
  else
    set nocursorline
    set nocursorcolumn
  endif
endfunction

function! s:set_cursorcross(column, line, message)
  if g:cursorcross_debug
    echomsg a:message
  endif
  if s:cursorcross
    if a:line
      set cursorline
    else
      set nocursorline
    endif
    if a:column
      set cursorcolumn
    else
      set nocursorcolumn
    endif
  else
    set nocursorcolumn
    set nocursorline
  endif
endfunction


" Autocommands:

augroup cursorgroup
  " BufWinEnter seems to be executed last (i.e. for the quickfix window, after nomodifiable has been set)
  autocmd!
  autocmd   BufWinEnter                 *                   call <SID>set_cursorcross(0, 1, 'bufwinenter')
  autocmd   InsertEnter                 *                   call <SID>set_cursorcross(1, 0, 'insertenter')
  autocmd   InsertLeave                 *                   call <SID>set_cursorcross(0, 1, 'insertleave')
  autocmd   WinEnter                    *                   call <SID>set_cursorcross(0, 1, 'winenter')
  autocmd   WinLeave                    *                   call <SID>set_cursorcross(0, 0, 'winleave')
augroup END


" Commands:

command! -nargs=0 CursorcrossToggle call <SID>toggle_cursorcross()
command! -nargs=0 CursorcrossOff call <SID>toggle_cursorcross(0)
command! -nargs=0 CursorcrossOn call <SID>toggle_cursorcross(1)


" Mappings:

if g:cursorcross_mappings
  nnoremap <silent> + :call <SID>toggle_cursorcross()<cr>
  noremap - :set cursorline!<cr>
  nnoremap \| :set cursorcolumn!<cr>
  vnoremap \| <esc>:set cursorcolumn!<cr>gv
endif
