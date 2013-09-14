" autoload/cursorcross.vim


" dictionary of [cursorcolumn, cursorline] states indexed by buffer number
let s:cursorcross_state = {}

function! s:is_dynamic()
  " check if the current buffer is among the exceptions
  return g:cursorcross_dynamic && match(g:cursorcross_exceptions, &filetype) ==# -1
endfunction

function! s:is_at_beginning_of_line()
  " check if cursor is at beginning of line
  let cursor_column = col('.')
  return cursor_column ==# 1 || match(getline('.')[:cursor_column - 2], '^\s*$') ==# 0
endfunction

function! cursorcross#on_enter()
  " restore highlighting if possible, else do default
  let cur_bufnr = bufnr('%')
  if has_key(s:cursorcross_state, cur_bufnr)
    let [&l:cursorcolumn, &l:cursorline] = s:cursorcross_state[cur_bufnr]
  elseif s:is_dynamic()
    setlocal cursorline
  endif
endfunction

function! cursorcross#on_leave()
  " remove all highlighting and store state
  let s:cursorcross_state[bufnr('%')] = [&cursorcolumn, &cursorline]
  setlocal nocursorcolumn
  setlocal nocursorline
endfunction

function! cursorcross#on_insert(direction)
  " if entering, cursorline; if leaving, cursorcolumn
  if s:is_dynamic()
    if a:direction ==# 'enter'
      let cursor_column = col('.')
      if s:is_at_beginning_of_line()
        setlocal cursorcolumn
      endif
      setlocal nocursorline
    elseif a:direction ==# 'leave'
      setlocal nocursorcolumn
      setlocal cursorline
    else
      throw 'Invalid direction.'
    endif
  endif
endfunction

function! cursorcross#on_char_insert()
  " enable cursorcolumn if at beginning of line else deactivate
  if match(v:char, '\s') >=# 0 && s:is_at_beginning_of_line()
    setlocal cursorcolumn
  else
    setlocal nocursorcolumn
  endif
endfunction

function! cursorcross#on_enter_insert()
  " <cr> doesn't trigger InsertCharPre so we handle it separately
  if s:is_dynamic()
    setlocal cursorcolumn
  endif
  return "\<cr>"
endfunction

function! cursorcross#toggle_dynamic_mode(...)
  " toggle dynamic mode
  if a:0
    let g:cursorcross_dynamic = a:1
  else
    let g:cursorcross_dynamic = !g:cursorcross_dynamic
  endif
  let prefix = g:cursorcross_dynamic ? '' : 'no'
  echo prefix . 'dynamic'
endfunction
