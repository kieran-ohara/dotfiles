" vim: set foldmethod=marker foldlevel=0 nomodeline:
source $XDG_CONFIG_HOME/vim/universal.vim

set directory=$XDG_CACHE_HOME/nvim/swapfiles//
set backupdir=$XDG_CACHE_HOME/nvim/backupfiles//
set undodir=$XDG_CACHE_HOME/nvim/undodir

luafile ~/.config/nvim/config/autocomplete.lua
luafile ~/.config/nvim/config/dap.lua
luafile ~/.config/nvim/config/lsp-servers.lua
luafile ~/.config/nvim/config/lsp.lua
luafile ~/.config/nvim/config/treesitter.lua
luafile ~/.config/nvim/config/ui.lua

function! OpenSwps()
    execute "!open ". $XDG_CACHE_HOME. "/nvim/swapfiles"
endfunc

colorscheme nightfox
let g:lightline = {}
let g:lightline.colorscheme = 'nightfox'

nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>

" VCS config
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gc :Git commit -v -q<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gsT :Git<CR>
nnoremap <leader>gst :vertical Git<CR>
