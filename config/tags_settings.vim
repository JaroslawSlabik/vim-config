 " enable gtags module if exists
let g:gutentags_ctags_tagfile = '.tags'

" enable gtags module if exists
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" config project root markers.
let g:gutentags_project_root = ['.git', '.svn', '.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 0

" ERROR: gutentags: gtags-cscope job failed, returned: 1
let g:gutentags_define_advanced_commands = 1
"step1: add the line below to your .vimrc:
"let g:gutentags_define_advanced_commands = 1
"step2: restart vim and execute command:
":GutentagsToggleTrace
"step3: open some files and generate gtags again with current project:
":GutentagsUpdate
"step4: you may see a lot of gutentags logs, after that:
":messages
"To see the gtags log.

" auto run ctags
let g:gutentags_auto_add_gtags_cscope = 1

" disable default keymaps
let g:gutentags_plus_nomap = 1

" my keymaps
" Find symbol (reference) under cursor
map <F3> :GscopeFind s <C-R><C-W><CR> :copen <CR>
" Find symbol definition under cursor
map <F4> :GscopeFind g <C-R><C-W><CR> :copen <CR>
" Find file name under cursor
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
