set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << EOF
require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
EOF

function! LanguageClientMaps()
    nnoremap <buffer> K :lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> gd :lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> <F2> :lua vim.lsp.buf.rename()<CR>

    inoremap <buffer> <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <buffer> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endfunction
augroup lcmaps
    autocmd!
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact call LanguageClientMaps()
augroup end
