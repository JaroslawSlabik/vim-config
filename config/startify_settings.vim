set shortmess=I

" 'Most Recent Files' number
let g:startify_files_number           = 18

" Update session automatically as you exit vim
let g:startify_session_persistence    = 1

" Simplify the startify list to just recent files and sessions
let g:startify_lists = [
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
  \ { 'type': 'files',     'header': ['   Recent files'] },
  \ ]

" Fancy custom header
let g:startify_custom_header = [
  \ '',
  \ '   ╻ ╻   ╻   ┏┳┓',
  \ '   ┃┏┛   ┃   ┃┃┃',
  \ '   ┗┛    ╹   ╹ ╹',
  \ '',
  \ ]

" If open new bufer then run Startify
if bufname('%') == '' && line('$') == 1 && getline(1) == ''
    autocmd VimEnter * Startify"
endif

" Problem during load session with NERDTree FIXME pleases
