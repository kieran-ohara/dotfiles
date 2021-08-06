set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << EOF
require'lspconfig'.tsserver.setup{}
EOF

function! LanguageClientMaps()
    nnoremap <buffer> K :lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> gd :lua vim.lsp.buf.definition()<CR>
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endfunction
augroup lcmaps
    autocmd!
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact call LanguageClientMaps()
augroup end
