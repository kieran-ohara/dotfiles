function! s:OpenPWD()
  let l:pwd = getcwd()
  execute "!open " . l:pwd
endfunction

function! s:OpenSwaps()
  let l:swapfiles = &directory
  execute "!open " . l:swapfiles
endfunction

nnoremap <Plug>(my-plugin-do-something) :call MyPluginFunction()<CR>

nnoremap <Plug>(open-pwd) :call <SID>OpenPWD()<CR>
nnoremap <Plug>(open-swaps) :call <SID>OpenSwaps()<CR>

nnoremap <leader>o. <Plug>(open-pwd)
nnoremap <leader>os <Plug>(open-swaps)
