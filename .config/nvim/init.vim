set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

luafile ~/.config/nvim/initlua.lua
luafile ~/.config/nvim/lsp.lua

nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> gp :Lspsaga preview_definition<CR>
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr :Lspsaga rename<CR>
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> ga :Lspsaga code_action<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR> compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
