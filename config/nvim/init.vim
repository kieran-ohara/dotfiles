" vim: set foldmethod=marker foldlevel=0 nomodeline:
source $XDG_CONFIG_HOME/vim/universal.vim

set directory=$XDG_CACHE_HOME/nvim/swapfiles//
set backupdir=$XDG_CACHE_HOME/nvim/backupfiles//
set undodir=$XDG_CACHE_HOME/nvim/undodir

luafile ~/.config/nvim/initlua.lua
luafile ~/.config/nvim/lsp.lua

function! OpenSwps()
    execute "!open ". $XDG_CACHE_HOME. "/nvim/swapfiles"
endfunc
" Code Editing {{{

" Don't show indent lines by default.
let g:indentLine_enabled = 0
let g:indentLine_char_list = ['|', '¦', '┊']

" }}}

colorscheme tokyonight

let g:lightline = {}
let g:lightline.colorscheme = 'tokyonight'

nnoremap <leader>sh :SidewaysLeft<CR>
nnoremap <leader>sl :SidewaysRight<CR>

nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)

nnoremap <leader>ff :Telescope git_files<CR>
nnoremap <leader>fu :Telescope buffers<CR>

function! SetBufferRootDir()
    if getbufinfo('%')[0]['listed'] && filereadable(@%)
        let l:root = fnamemodify(FugitiveGitDir(), ":h")
        if isdirectory(l:root)
            execute 'lcd ' . l:root
        endif
    endif
endfunction
augroup bufferroot
    " When opening a buffer, set the root directory.
    autocmd BufWinEnter * call SetBufferRootDir()
augroup end


let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascript = ['javascript']
let g:vsnip_filetypes.typescript = ['typescript']
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

" Dispatch
nnoremap <leader>df :Focus make<space>
nnoremap <leader>dr :Focus!<CR>
nnoremap <leader>ds :Start<CR>

" Test
nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>tl :TestLast<CR>

" lsp
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> gp :Lspsaga preview_definition<CR>
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr :Lspsaga rename<CR>
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> ga :Lspsaga code_action<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=
