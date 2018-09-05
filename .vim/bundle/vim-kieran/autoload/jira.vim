function! jira#ticketFromBranch() abort
    let branch= gitbranch#name()
    let ticket = matchstr(branch, '\w\+-\d\+')
    if empty(ticket)
        throw "no ticket recognized in ``".branch."''"
    endif
    return ticket
endfunction

function! jira#browse(ticket) abort
    execute "!jira browse " . a:ticket
endfunction

function! jira#comment(ticket) abort
    execute "!jira comment " . a:ticket
endfunction

function! jira#fzf_ui()
    call fzf#run({'source': 'jira chronos_all',
                \ 'options': '-d:
                \ --preview "jira view {1} -t fzf_preview"
                \ --preview-window right:wrap
                \ --expect=ctrl-b,ctrl-e',
                \ 'sink*': function('jira#fzf_sink')})
endfunction

function! jira#fzf_sink(lines)
    let Handler = function(get({
                \ 'ctrl-b': 'jira#browse'
                \ }, a:lines[0], 'jira#browse'))
    let ticket = split(a:lines[1], ":")
    call Handler(ticket[0])
endfunction
