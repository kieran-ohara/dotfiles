" Author: Kieran Bamforth - https://github.com/kieran-bamforth
" Description: Javascript/Typescript Language Server https://github.com/sourcegraph/javascript-typescript-langserver

call ale#Set('javascript_jstsls_host', '127.0.0.1')
call ale#Set('javascript_jstsls_port', '2089')

function! ale#jstsls#GetAddress(buffer) abort
    let l:host = ale#Var(a:buffer, 'javascript_jstsls_host')
    let l:port = ale#Var(a:buffer, 'javascript_jstsls_port')
    let l:address = l:host . ':' . l:port
    return l:address
endfunction

" Find the nearest dir containing a potential project.
function! ale#jstsls#FindProjectRoot(buffer) abort
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

call ale#linter#Define('javascript', {
\   'name': 'jstsls',
\   'lsp': 'socket',
\   'address_callback': 'ale#jstsls#GetAddress',
\   'language': 'javascript',
\   'project_root_callback': 'ale#jstsls#FindProjectRoot',
\})
