" autoload/cursorcross.vim

" dictionary of [cursorcolumn, cursorline] states indexed by buffer number
let s:cursorcross_state = {}
" whether the plugin is active or has been disabled
let s:cursorcross_active = 1

function! s:is_active()
  " check if the current buffer is among the exceptions
  return
  \ (!strlen(&filetype) || match(g:cursorcross_exceptions, &filetype) ==# -1)
  \ && !strlen(&buftype) && s:cursorcross_active
endfunction

function! s:is_dynamic(key)
  " check if component is dynamic
  return match(g:cursorcross_dynamic, a:key) >=#0
endfunction

function! s:is_at_beginning_of_line(padding)
  " check if cursor is at beginning of line
  let ccol = col('.') - a:padding
  return ccol ==# 1 || match(getline('.')[:ccol - 2], '^\s*$') ==# 0
endfunction

function! cursorcross#toggle()
  " toggle plugin globally
  let s:cursorcross_active = !s:cursorcross_active
endfunction

function! cursorcross#on_enter()
  " restore highlighting if possible, else do default
  if s:is_active() && s:is_dynamic('w')
    let cur_bufnr = bufnr('%')
    if has_key(s:cursorcross_state, cur_bufnr)
      let [&l:cursorcolumn, &l:cursorline] = s:cursorcross_state[cur_bufnr]
    elseif s:is_dynamic('l')
      setlocal cursorline
    endif
  endif
endfunction

function! cursorcross#on_leave()
  " remove all highlighting and store state
  if s:is_active() && s:is_dynamic('w')
    let s:cursorcross_state[bufnr('%')] = [&cursorcolumn, &cursorline]
    setlocal nocursorcolumn
    setlocal nocursorline
  endif
endfunction

function! cursorcross#on_insert(direction)
  " if entering, cursorline; if leaving, cursorcolumn
  if s:is_active()
    if a:direction ==# 'enter'
      let cursor_column = col('.')
      if s:is_dynamic('c') && s:is_at_beginning_of_line(0)
        setlocal cursorcolumn
      endif
      if s:is_dynamic('l')
        setlocal nocursorline
      endif
    elseif a:direction ==# 'leave'
      if s:is_dynamic('c')
        setlocal nocursorcolumn
      endif
      if s:is_dynamic('l')
        setlocal cursorline
      endif
    else
      throw 'Invalid direction.'
    endif
  endif
endfunction

function! cursorcross#on_char_insert()
  " enable cursorcolumn if at beginning of line else deactivate
  if s:is_active() && s:is_dynamic('c')
    if match(v:char, '\s') >=# 0 && s:is_at_beginning_of_line(0)
      setlocal cursorcolumn
    else
      setlocal nocursorcolumn
    endif
  endif
endfunction

function! cursorcross#on_enter_insert()
  " <cr> doesn't trigger InsertCharPre so we handle it separately
  if s:is_active() && s:is_dynamic('c')
    setlocal cursorcolumn
  endif
  return ''
endfunction

function! cursorcross#on_backspace()
  " <bs> doesn't trigger InsertCharPre so we handle it separately
  if s:is_active() && s:is_dynamic('c') && s:is_at_beginning_of_line(1)
    setlocal cursorcolumn
  endif
  return ''
endfunction
