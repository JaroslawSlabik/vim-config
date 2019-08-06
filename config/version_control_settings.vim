" svngutter
let g:svngutter_signs = 1
let g:svngutter_enabled = 1
let g:svngutter_highlight_lines = 1


function! g:SvnExists()
    if (executable('svn') == 0)
        return v:false " not installed SVN
    endif

    return v:true " installed SVN
endfunction


function! g:GitExists()
    if (executable('git') == 0)
        return v:false " not installed GIT
    endif

    return v:true " installed GIT
endfunction


function! g:IdentifyCurrentWorkCopy()
    let git_exists = g:GitExists()
    let svn_exists = g:SvnExists()

    if git_exists == v:false && svn_exists == v:false
        return -1 " not installed GIT and SVN
    endif

    let git_work_copy_exists = v:false
    let svn_work_copy_exists = v:false

    " Test GIT when GIT exists
    if (git_exists == v:true)
        let sys_out = system("git ls-remote --get-url")
        if (sys_out =~ ".git")
            let git_work_copy_exists = v:true " Test OK, it is GIT working copy
        endif
    endif

    " Test SVN when SVN exists
    if (svn_exists == v:true)
        let sys_out = system("svn info")
        if (sys_out =~ "URL")
            let svn_work_copy_exists = v:true " Test OK, it is SVN working copy
        endif
    endif

    " If it is not SVN working copy and it is not GIT working copy then return -2
    if git_work_copy_exists == v:false && svn_work_copy_exists == v:false
        return -2
    endif

    " If it is GIT working copy then return 1
    if git_work_copy_exists == v:true
        return 1
    endif

    " If it is SVN working copy then return 2
    if svn_work_copy_exists == v:true
        return 2
    endif

    " Some else return 0
    return 0

endfunction


" Diff functions
function! g:GetSvnRepoURLFromFile(full_path_to_file)
    " Get URL of SVN file in repo
    return system('svn info ' . a:full_path_to_file . ' --show-item=url --no-newline')
endfunction


function! g:DownloadFileFromSvnURL(url, full_path_to_file)
    " Download (not checkout) file on SVN  repo on base URL
    silent execute '!svn export ' . a:url . ' ' . a:full_path_to_file
endfunction


function! g:GetGitRepoURLFromFile(full_path_to_file)
    " Get URL of GIT repo and delete end address (.git) for example: https://github.com/my/gitrepo.git to https://github.com/my/gitrepo
    let s:url_to_repo = substitute(system("git ls-remote --get-url"), '.git\n', '', 'g')
    " Change https://github.com/my/gitrepo to https://raw.githubusercontent.com/my/gitrepo
    let s:url_to_repo = substitute(s:url_to_repo, 'github.com', 'raw.githubusercontent.com', 'g')
    " Get current branch
    let s:current_branch = substitute(system("git rev-parse --abbrev-ref HEAD"), '\n', '', 'g')
    " Get full path to GIT workin copy on main dir (Wher is dir .git)
    let s:main_dir_local_repo = substitute(system("git rev-parse --show-toplevel"), '\n', '', 'g')
    " Change full path to file in working copy to path to file in repo for example: path /home/my/dir/repo_git_main_dir/some/file to path repo_git_main_dir/some/file
    let s:path_remote_repo = strpart(a:full_path_to_file, strchars(s:main_dir_local_repo) + 1)
    " Make URL
    return s:url_to_repo . "/" . s:current_branch . "/" .  s:path_remote_repo
endfunction


function! g:DownloadFileFromGitURL(url, full_path_to_file)
    " Download file on GIT repo on base URL via WGET
    silent execute '!wget -O ' . a:full_path_to_file . ' ' . a:url
endfunction


let g:head_file_to_diff = ''
function! RunDiffOnCurrentFile()
    " Identify working copy and check SVN or GIT exists
    let identify_work_copy = g:IdentifyCurrentWorkCopy()
    if (identify_work_copy == -1 || identify_work_copy == -2)
        return v:false
    endif

    " run diff mode on current file
    execute 'diffthis'

    " Set HEAD string
    let full_path_to_current_file = expand('%:p')
    let g:head_file_to_diff = full_path_to_current_file . ".revHEAD"

    " Download HEAD revision of current file for GIT
    if (identify_work_copy == 1)
        let url = g:GetGitRepoURLFromFile(full_path_to_current_file)
        call g:DownloadFileFromGitURL(url, g:head_file_to_diff)
    endif

    " Download HEAD revision of current file for SVN
    if (identify_work_copy == 2)
        let url = g:GetSvnRepoURLFromFile(full_path_to_current_file)
        call g:DownloadFileFromSvnURL(url, g:head_file_to_diff)
    endif

    " Open downloaded HEAD revision on vertical split
    execute 'vert sview ' . g:head_file_to_diff

    " run diff mode on HEAD revision file
    execute 'diffthis'
endfunction
map <F10> :call RunDiffOnCurrentFile()<CR>


function! EndDiffOnCurrentFile()
    " deactivation diff mode on all buffers
    bufdo execute 'diffoff'

    " close buffers wher is HEAD file
    execute 'bd ' .  g:head_file_to_diff

    " delete HEAD file
    if g:win_shell
        silent execute '!del /f ' . g:head_file_to_diff
    else
        silent execute '!rm ' . g:head_file_to_diff
    endif

    " clear HEAD string
    let g:head_file_to_diff = ''
endfunction
map <F11> :call EndDiffOnCurrentFile()<CR>

"TODO: Add current file do commit
function! AddCurrentFile()
    " Identify working copy and check SVN or GIT exists
    let identify_work_copy = g:IdentifyCurrentWorkCopy()
    if (identify_work_copy == -1 || identify_work_copy == -2)
        return v:false
    endif

    let full_path_to_current_file = expand('%:p')

    " for GIT
    if (identify_work_copy == 1)
        let git_add_output = system("git add " . full_path_to_current_file)
        return v:true
    endif

    " for SVN
    if (identify_work_copy == 2)
        let svn_add_output = system("svn add " . full_path_to_current_file)
        return v:true
    endif

    return v:false
endfunction

"TODO: Commit main dir with message
function! CommitMainDirOfCurrentWorkingCopy(commit_message)
    " Identify working copy and check SVN or GIT exists
    let identify_work_copy = g:IdentifyCurrentWorkCopy()
    if (identify_work_copy == -1 || identify_work_copy == -2)
        return v:false
    endif

    " for GIT
    if (identify_work_copy == 1)
        let git_commit_output = system('git commit -m "' . a:commit_message . '"')
        return v:true
    endif

    " for SVN
    if (identify_work_copy == 2)
        let svn_commit_output = system('svn commit -m "' . a:commit_message . '"')
        return v:true
    endif

    return v:false
endfunction

"TODO: Push only GIT
function! PushMainDirOfCurrentWorkingCopy()
    " Identify working copy and check SVN or GIT exists
    let identify_work_copy = g:IdentifyCurrentWorkCopy()
    if (identify_work_copy == -1 || identify_work_copy == -2)
        return v:false
    endif

    " for GIT
    if (identify_work_copy == 1)
        " Get current branch
        let current_branch = substitute(system("git rev-parse --abbrev-ref HEAD"), '\n', '', 'g')
        let git_commit_output = system('git push origin ' . current_branch )
        return v:true
    endif

    " for SVN
    if (identify_work_copy == 2)
        return v:false
    endif

    return v:false
endfunction

