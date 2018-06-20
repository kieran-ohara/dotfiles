function! jira#getticket() abort
    let branch= gitbranch#name()
    let ticket = matchstr(branch, '\w\+-\d\+')
    if empty(ticket)
        throw "no ticket recognized in ``".branch."''"
    endif
    return ticket
endfunction

function! jira#browse() abort
    execute "!jira browse " . jira#getticket()
endfunction

function! jira#comment() abort
    execute "!jira comment " . jira#getticket()
endfunction
