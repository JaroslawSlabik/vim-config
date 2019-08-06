syntax on

let g:color_coded_enabled = 1
let g:color_coded_filetypes = ['c', 'cpp', 'h', 'hpp']

augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "\uE286" "✗
let g:syntastic_warning_symbol = "\u26A1" "⚡
let g:syntastic_enable_balloons = 1
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_skip_checks = 0
let g:syntastic_cpp_check_header = 1
let s:cpp_options_list = ['-std=c++11',
                        \ '-Wall',
                        \]
let g:syntastic_cpp_compiler_options = join(s:cpp_options_list, ' ')
set completeopt-=preview				" hide preview window
let g:syntastic_stl_format = '%W{dd[%fwjj(#%w)]} %E{[%fe(#%e)]}'

let g:clang_library_path='/usr/lib/llvm-3.9/lib/'
