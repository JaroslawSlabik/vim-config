 " przy nowej linii używaj tego samego wcięcia co w obecnej
set autoindent

" dddd
set showcmd

" wwww
set hlsearch

" wwwww
set incsearch

" wwww
set backspace=indent,eol,start

" tab ustawiony na 4 space
set ts=4
set sts=4
set sw=4
set expandtab

" kodowanie ustawiane na UTF-8
set encoding=utf-8
"set fileencodings=usc-bom,utf-8,latin2
"set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8

" ustawione na „a” – w trybach normal mode, insert mode, visual mode i command mode, będzie działać obaługa myszy, czyli klikanie i scrollowanie
set mouse=a
" Alway show status bar at bottom
set laststatus=2
set statusline=

"  ustawienie linii z informacjami o otwartym pliku
set ruler

" ustawienie danych wyświetlanych w tej linii
set rulerformat=%40(%y/%{&fenc}/%{&ff}%=%l,%c%V%5(%P%)%)

" włączenie numerowania linijek
set number

" te dwie linie spowodują, że Vim zapamięta pozycję w pliku gdzie był ustawiony kursor przy ostatniej edycji, dzięki czemu po ponownym otwarciu, automatycznie przejdzie do tej pozycji
"autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") |
"    \ exe "normal `\"" | endif

" ----- Toggle GUI -----
map <F8> :TagbarToggle<CR>

function! ToggleGUI()
  if &guioptions=='i'
    exec('set guioptions=imTrL')
  else
    exec('set guioptions=i')
  endif
endfunction

map <F11> <Esc>:call ToggleGUI()<cr>

" by default, hide gui menus
set guioptions=i

" Ctr-S Save like notepad++ on all modes (:w (write) zmienia czas zapisu nawet gdy nie było zmian, :up (update) zmienia czas zapisu tylko wtedy gdy były zmiany)
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" copy-paste CTRL-C, CTRL-V i CTRL-X
" CTRL-Q is go to Visual Block
vmap <C-C> "+yi
vmap <C-X> "+c
vmap <C-V> i<ESC>"+pa
imap <C-V> <ESC>"+pa
nmap <C-V> i<ESC>"+pa

set colorcolumn=130
set antialias=on
"windows
"set guifont=Hack_NF:h12
"linux
set guifont=FuraCode\ Nerd\ Font\ Mono\ 12

"" Split
set splitright
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

