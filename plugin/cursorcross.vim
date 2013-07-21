" Cursorcross:
"
" Dynamic cursorcolumn and cursorline updates.


" Options:

if (exists('g:cursorcross_disable') && g:cursorcross_disable) || &cp
  finish
endif

if !exists('g:cursorcross_dynamic')
  let g:cursorcross_dynamic = 1
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

" Initialization:

if g:cursorcross_dynamic
  set cursorline
  let s:cursorcross = 1
else
  let s:cursorcross = 0
endif


" Functions:

function! s:is_exception(ftype)
  for exception in g:cursorcross_exceptions
    if a:ftype ==# exception
      return 1
    endif
  endfor
  return 0
endfunction

function! s:toggle_cursorcross(force, verbose,  ...)
  if a:0
    let s:cursorcross_save = s:cursorcross
    let s:cursorcross = a:1
  else
    if exists('s:cursorcross_save')
      let s:cursorcross = s:cursorcross_save
      unlet s:cursorcross_save
    else
      let s:cursorcross = !s:cursorcross
    endif
  endif
  if a:force
    call s:set_cursorcross(0, 1, 'toggle')
  endif
  if a:verbose
    if s:cursorcross
      echo 'cursorcross'
    else
      echo 'nocursorcross'
    endif
  endif
endfunction

function! s:set_cursorcross(column, line, message)
  if g:cursorcross_debug
    echomsg a:message . ' ' . &ft
  endif
  if s:cursorcross && !s:is_exception(&ft)
    " cursorline hides quickfix window highlighting
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
  autocmd   FileType                    *                   call <SID>set_cursorcross(0, 1, 'filetype')
  autocmd   InsertEnter                 *                   call <SID>set_cursorcross(1, 0, 'insertenter')
  autocmd   InsertLeave                 *                   call <SID>set_cursorcross(0, 1, 'insertleave')
  autocmd   WinEnter                    *                   call <SID>set_cursorcross(0, 1, 'winenter')
  autocmd   WinLeave                    *                   call <SID>set_cursorcross(0, 0, 'winleave')
augroup END


" Commands:

command! -bang -nargs=0 CursorcrossToggle call <SID>toggle_cursorcross(<bang>0, 0)
command! -nargs=0 CursorcrossOff call <SID>toggle_cursorcross(1, 0, 0)
command! -nargs=0 CursorcrossOn call <SID>toggle_cursorcross(1, 0, 1)


" Mappings:

if g:cursorcross_mappings
  nnoremap <silent> + :call <SID>toggle_cursorcross(1, 1)<cr>
  noremap - :set cursorline!<cr>
  nnoremap \| :set cursorcolumn!<cr>
  vnoremap \| <esc>:set cursorcolumn!<cr>gv
endif
