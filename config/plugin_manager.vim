set nocompatible
filetype off
"set runtimepath for vundle in Windows and Linux
let vimDir = g:win_shell ? '$HOME/Vim/vimfiles' : '$HOME/.vim/vimfiles'
let &runtimepath .= ',' . expand(vimDir . '/bundle/Vundle.vim')
let path_to_bundle = expand(vimDir . '/bundle')

call vundle#rc(path_to_bundle)
call vundle#begin(path_to_bundle)
"Plugin 'VundleVim/Vundle.vim'

" ----- Colorus -----
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ryanoasis/vim-devicons'

" ----- Nerd Tree -----
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'amiorin/vim-project'
Plugin 'a.vim'
Plugin 'mhinz/vim-startify'

Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/lh-tags'
Plugin 'LucHermitte/lh-dev'
Plugin 'LucHermitte/lh-style'
Plugin 'LucHermitte/vim-refactor'

Plugin 'majutsushi/tagbar'

" ----- Syntastic and completion -----
Plugin 'vim-syntastic/syntastic'
Plugin 'ervandew/supertab'
Plugin 'jeaye/color_coded'
Plugin 'xavierd/clang_complete'
Plugin 'shmup/vim-sql-syntax'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'skywind3000/gutentags_plus'

" ----- GDB -----
Plugin 'vim-scripts/Conque-GDB'

Plugin 'ntpeters/vim-better-whitespace'

" ----- Subversion -----
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/vim-svngutter'


call vundle#end()
filetype plugin indent on


