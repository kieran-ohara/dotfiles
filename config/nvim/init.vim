" vim: set foldmethod=marker foldlevel=0 nomodeline:
source $XDG_CONFIG_HOME/vim/universal.vim

set directory=$XDG_STATE_HOME/nvim/swapfiles//
set backupdir=$XDG_STATE_HOME/nvim/backupfiles//
set undodir=$XDG_STATE_HOME/nvim/undodir

function! OpenSwps()
    execute "!open ". $XDG_STATE_HOME. "/nvim/swapfiles"
endfunc

colorscheme terafox

nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
