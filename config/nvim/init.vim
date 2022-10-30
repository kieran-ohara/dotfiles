" vim: set foldmethod=marker foldlevel=0 nomodeline:
source $XDG_CONFIG_HOME/vim/universal.vim

set directory=$XDG_CACHE_HOME/nvim/swapfiles//
set backupdir=$XDG_CACHE_HOME/nvim/backupfiles//
set undodir=$XDG_CACHE_HOME/nvim/undodir

luafile ~/.config/nvim/initlua.lua

luafile ~/.config/nvim/autocomplete.lua
luafile ~/.config/nvim/lsp.lua
luafile ~/.config/nvim/treesitter.lua

function! OpenSwps()
    execute "!open ". $XDG_CACHE_HOME. "/nvim/swapfiles"
endfunc

" Code Editing {{{
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> gp :Lspsaga preview_definition<CR>
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr :Lspsaga rename<CR>
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> ga :Lspsaga code_action<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
" }}}
" Navigation {{{
nnoremap <leader>fh :Telescope command_history<CR>
nnoremap <leader>ff :Telescope git_files<CR>
nnoremap <leader>fu :Telescope buffers<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
" }}}
" UI {{{
colorscheme nightfox
let g:lightline = {}
let g:lightline.colorscheme = 'nightfox'
" }}}
