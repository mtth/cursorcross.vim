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
  " Skip BufEnter/FileType during startup, which could trigger it for multiple
  " windows.
  autocmd BufEnter * if !has('vim_starting') | silent call cursorcross#on_enter() | endif
  autocmd InsertEnter * silent call cursorcross#on_insert('enter')
  autocmd InsertLeave * silent call cursorcross#on_insert('leave')
  autocmd InsertCharPre * silent call cursorcross#on_char_insert()
  autocmd WinEnter * silent call cursorcross#on_enter()
  autocmd WinLeave * silent call cursorcross#on_leave()
  " Handle opening Vim with a single window.
  autocmd VimEnter * silent call cursorcross#on_enter()
augroup END

command! -nargs=0 CursorcrossToggle call cursorcross#toggle()

" Mappings {{{1
inoremap <silent> <SID>CursorCrossCR  <C-R>=cursorcross#on_enter_insert()<CR>
imap     <script> <Plug>CursorCrossCR <SID>CursorCrossCR
inoremap <silent> <SID>CursorCrossBS  <C-R>=cursorcross#on_backspace()<CR>
imap     <script> <Plug>CursorCrossBS <SID>CursorCrossBS

" Forward any existing CR maps, initially based on endwise's code.

" Helper to setup CursorCrossBS/CursorCrossCR maps.
" Args: key: 'CR' or 'BS'
fun! s:setup_map(key)
  if exists('g:cursorcross_no_map_'.a:key) && eval('g:cursorcross_no_map_'.a:key)
    " Skip map setup, if requested by user via g:cursorcross_no_map_X.
    return
  endif
  let maparg = maparg('<'.a:key.'>', 'i')
  if maparg =~# '<\%(Plug\|SNR\|SID\)>CursorCross'.a:key
    " Already mapped
  elseif maparg =~ '<\%(Plug\|SNR\|SID\)>\w\+'.a:key
    " Forward any existing Plug/SNR/SID maps.
    exe "imap          <".a:key."> ".maparg."<".a:key."><Plug>CursorCross".a:key
  elseif maparg =~ '<'.a:key.'>'
    " Forward any existing maps to a:key, but with script-local remapping only.
    exe "imap <script> <".a:key."> ".maparg."<".a:key."><Plug>CursorCross".a:key
  else
    " Use <unique> to get a warning, if user maps would get overwritten,
    " then catch the error and provide help to fix it.
    try
      exe 'imap <unique> <'.a:key.'> <'.a:key.'><Plug>CursorCross'.a:key

    catch /^Vim\%((\a\+)\)\=:E227/	" E227: mapping already exists for ^M
      let exception_msg = substitute(v:exception, '^\S\+: ', '', '')
      echohl WarningMsg
      echom 'cursorcross: not overwriting existing '.a:key.' map ('.exception_msg.').'
            \ 'Set g:cursorcross_no_map_'.a:key.'=1 to skip it.'
      echohl None
    endtry
  endif
endfun
call s:setup_map('CR')
call s:setup_map('BS')

if g:cursorcross_mappings
  noremap  -  :set cursorline!<cr>
  nnoremap \| :set cursorcolumn!<cr>
  xnoremap \| <esc>:set cursorcolumn!<cr>gv
endif
" }}}1
