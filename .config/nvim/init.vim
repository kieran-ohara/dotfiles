" vim: set foldmethod=marker foldlevel=0 nomodeline
set runtimepath^=~/.vim
let &packpath = &runtimepath
set packpath^=~/.config/nvim
source ~/.vimrc

" Plugins {{{

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.config/nvim/bundle')


" Pickers
Plug 'nvim-lua/popup.nvim'


Plug 'Yggdroot/indentLine'
Plug 'direnv/direnv.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'janko-m/vim-test'
Plug 'junegunn/vim-easy-align'
Plug 'kshenoy/vim-signature'
Plug 'mattn/emmet-vim'
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'folke/trouble.nvim'

Plug 'itchyny/lightline.vim'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Has to be loaded at the end
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()
" }}}

luafile ~/.config/nvim/initlua.lua
luafile ~/.config/nvim/lsp.lua

" Code Editing {{{
augroup fileTypes
    autocmd!

    autocmd BufNewFile,BufRead *.conf setfiletype nginx
    autocmd BufNewFile,BufRead *.jsx setfiletype typescriptreact
    autocmd BufNewFile,BufRead *.puml setfiletype plantuml
    autocmd BufNewFile,BufRead .Brewfile setfiletype ruby
    autocmd BufNewFile,BufRead .env.* setfiletype sh
    autocmd BufNewFile,BufRead .npmrc setfiletype dosini
    autocmd BufNewFile,BufRead Dockerfile.* setfiletype dockerfile
    autocmd BufNewFile,BufRead hub setfiletype yaml

    autocmd BufWinLeave * call clearmatches()

    " Override tabs/spaces.
    autocmd FileType python setlocal tabstop=4 expandtab
    autocmd FileType json,ruby,yaml setlocal tabstop=2 expandtab
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal tabstop=2 expandtab
    autocmd FileType yaml let b:indentLine_enabled = 1

    autocmd FileType gitcommit,markdown,conf setlocal spell
    autocmd FileType gitcommit,markdown,conf setlocal linebreak
    autocmd FileType gitcommit,markdown,conf setlocal textwidth=80 colorcolumn=80

    autocmd FileType json setlocal formatprg='jq'

augroup end
" Dont conceal quotes when viewing JSON
let g:vim_json_syntax_conceal=0
" Do not overwrite makefile.
let plantuml_set_makeprg=0

" Don't show indent lines by default.
let g:indentLine_enabled = 0
let g:indentLine_char_list = ['|', '¦', '┊']

" Test strategy is Dispatch
let test#ruby#use_binstubs = 0
let test#strategy = "dispatch"
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

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR> compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=
