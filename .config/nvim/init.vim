set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << EOF
require'lspconfig'.tsserver.setup{}
require'nvim-treesitter.configs'.setup {
    ensure_installed = {},
    highlight = {
        enable = true,
    },
}
EOF

luafile ~/.config/nvim/initlua.lua

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

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
