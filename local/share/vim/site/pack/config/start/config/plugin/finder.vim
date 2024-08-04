function! s:OpenPWD()
  let l:pwd = getcwd()
  execute "!open " . l:pwd
endfunction

function! s:OpenSwaps()
  let l:swapfiles = &directory
  execute "!open " . l:swapfiles
endfunction

nnoremap <leader>o. :call <SID>OpenPWD()<CR>
nnoremap <leader>os :call <SID>OpenSwaps()<CR>
