" ---- Gotta be first ----
set nocompatible
scriptencoding utf-8
let g:win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'

" ---- General settings ----
:source  $HOME/.vim/config/general.vim

" ---- Plugin manager ----
:source $HOME/.vim/config/plugin_manager.vim

" ---- Set beautifull ----
:source $HOME/.vim/config/beautifull.vim

" ---- Syntax settings ----
:source $HOME/.vim/config/syntax.vim

" ---- Doxygen settings ----
:source $HOME/.vim/config/doxygen.vim

" ---- GDB settings ----
:source $HOME/.vim/config/gdb_settings.vim

" ---- Version control settings ----
:source $HOME/.vim/config/version_control_settings.vim

" ---- Project settings ----
:source $HOME/.vim/config/project_settings.vim

" ---- Tags settings ----
:source $HOME/.vim/config/tags_settings.vim

" ---- Start page (startify) settings ----
:source $HOME/.vim/config/startify_settings.vim
