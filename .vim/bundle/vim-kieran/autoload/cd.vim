function! cd#fzf_ui()
    call fzf#run({'source': 'ls',
                \ 'options': '--expect=ctrl-t --expect=ctrl-v --expect=ctrl-x',
                \ 'dir': '~/src/',
                \ 'down': '40%',
                \ 'sink*': function('cd#fzf_sink')})
endfunction

function! cd#fzf_sink(lines)
    let cmd = get({
                \ 'ctrl-t': 'tabe',
                \ 'ctrl-v': 'vsplit',
                \ 'ctrl-x': 'split'
                \ }, a:lines[0], 'lcd')
    let dir = '~/src/' . a:lines[1]
    execute cmd . ' ' . fnameescape(dir) . ' | lcd ' . fnameescape(dir)
endfunction
