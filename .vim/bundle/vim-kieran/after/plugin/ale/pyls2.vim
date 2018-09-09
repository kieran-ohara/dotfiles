" Author: Kieran Bamforth - https://github.com/kieran-bamforth
" Description: Python Language Server https://github.com/palantir/python-language-server

call ale#Set('python_pyls2_host', '127.0.0.1')
call ale#Set('python_pyls2_port', '2090')

function! ale#pyls2#GetAddress(buffer) abort
    let l:host = ale#Var(a:buffer, 'python_pyls2_host')
    let l:port = ale#Var(a:buffer, 'python_pyls2_port')
    let l:address = l:host . ':' . l:port
    return l:address
endfunction

" Find the nearest dir containing a potential project.
function! ale#pyls2#FindProjectRoot(buffer) abort
    let l:dir = ale#ruby#FindRailsRoot(a:buffer)
    if isdirectory(l:dir)
      return l:dir
    endif
    for l:name in ['package.json', 'requirements.txt']
        let l:dir = fnamemodify(
        \   ale#path#FindNearestFile(a:buffer, l:name),
        \   ':h'
        \)
        if l:dir isnot# '.' && isdirectory(l:dir)
            return l:dir
        endif
    endfor
    return ''
endfunction

call ale#linter#Define('python', {
\   'name': 'pyls2',
\   'lsp': 'socket',
\   'address_callback': 'ale#pyls2#GetAddress',
\   'language': 'python',
\   'project_root_callback': 'ale#pyls2#FindProjectRoot',
\})
