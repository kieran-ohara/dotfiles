" vim: set foldmethod=marker foldlevel=0 nomodeline:
" Plugins {{{

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/bundle')

" Syntax plugins.
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'cespare/vim-toml'
Plug 'chr4/nginx.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'hashivim/vim-terraform'
Plug 'maxmellon/vim-jsx-pretty', Cond(!has('nvim'))
Plug 'aklt/plantuml-syntax'
Plug 'nvim-treesitter/nvim-treesitter', Cond(has('nvim'), { 'branch': '0.5-compat'})

" Pickers
Plug 'junegunn/fzf', Cond(!has('nvim'))
Plug 'junegunn/fzf.vim', Cond(!has('nvim'))
Plug 'nvim-lua/popup.nvim' , Cond(has('nvim'))
Plug 'nvim-lua/plenary.nvim', Cond(has('nvim'))
Plug 'nvim-telescope/telescope.nvim', Cond(has('nvim'))

" Colour schemes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'folke/tokyonight.nvim', Cond(has('nvim'),{ 'branch': 'main' })

Plug 'AndrewRadev/sideways.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'alok/notational-fzf-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'direnv/direnv.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'ervandew/supertab'
Plug 'janko-m/vim-test'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-emoji'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'kshenoy/vim-signature'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'neovim/nvim-lspconfig', Cond(has('nvim'))
Plug 'nvim-lua/completion-nvim', Cond(has('nvim'))


Plug 'rizzatti/dash.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug '~/.vim/bundle/vim-kieran'

" Has to be loaded at the end
Plug 'ryanoasis/vim-devicons'
call plug#end()
" }}}
" Text Editing {{{
set cdpath+=~/src
set directory=~/.vim/swapfiles//
set backupdir=~/.vim/backupfiles//
set undodir=~/.vim/undodir
set undofile          " Persist undo

set clipboard=unnamed " Yank to * register (system clipboard)

set autoread          " Reload on external change.
set autowrite         " Auto write when navigating to different buffers.

set encoding=utf-8
set fixendofline      " Restore EOL if missing
set nobinary

set spelllang=en_gb   " English dictionary

set tabstop=4         " Use 4 spaces to indent
set shiftwidth=0      " No. of spaces to use for each indent (<<, >>, etc, 0 = tabstop).
set softtabstop=0     " What the tabs 'feel' like (0 = feature off)
set expandtab         " Use spaces to pad out a tab
set smarttab          " Tab at front of line inserts blanks according to tabstop

set autoindent        " Use indent from previous line
set smartindent       " Same as above but recognises C-like syntax (brackets et al.)

set formatoptions+=j  " Remove comment character when joining comments

set backspace=indent,eol,start

set nrformats-=octal  " CTRL-A does not mess with numbers starting with 0

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

nnoremap Q @q
nnoremap Y y$
vnoremap <leader>s :sort u<CR>
nnoremap <space>bd :bdelete<CR>
cnoremap <expr> %% getcmdtype() == ':' ? fnameescape(expand('%:h')).'/' : '%%'
nmap <space>sa :saveas %%

nnoremap <leader>sh :SidewaysLeft<CR>
nnoremap <leader>sl :SidewaysRight<CR>
nnoremap <leader>w :w<CR>

nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)

function! StripTrailingWhitespaces()
    "Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")

    " Do the business:
    %s/\s\+$//e

    " Clean up: restore previous search history / cursor
    let @/=_s
    call cursor(l, c)
endfunc
augroup stripspaces
    autocmd!
    autocmd BufWritePre * :call StripTrailingWhitespaces()
    autocmd InsertEnter * match ErrorMsg /\s\+\%#\@<!$/
    autocmd BufWinEnter,InsertLeave * match ErrorMsg /\s\+$/
augroup end

" }}}
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

" ALE
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:ale_linters={
            \'python':['prospector']
            \}
let g:ale_fixers = {
            \'python': ['black']
            \}
let g:ale_python_pyls_use_global = 1
let g:ale_python_black_options = '-l 79'

highlight! link ALEWarningSign ALEWarning

" Test strategy is Dispatch
let test#ruby#use_binstubs = 0
let test#strategy = "dispatch"
" }}}
" Navigation {{{
set ignorecase " Case insensitive search unless there's a mix
set smartcase
set hlsearch   " Highlight previous/current matches as they are typed
set incsearch

" Sneak config
let g:sneak#label = 1
highlight! link Sneak Search
highlight! link SneakScope Search
nmap F <Plug>Sneak_F
nmap T <Plug>Sneak_T
nmap f <Plug>Sneak_f
nmap t <Plug>Sneak_t

nnoremap <expr> N  'nN'[v:searchforward]
nnoremap <expr> n  'Nn'[v:searchforward]

if !has('nvim')
    nnoremap <C-p> :FZF<CR>
    nnoremap <leader>ff :GFiles<CR>
    nnoremap <leader>fh :History:<CR>
    nnoremap <leader>fu :Buffers<CR>
endif
if has('nvim')
    nnoremap <C-p> :Telescope find_files<CR>
    nnoremap <leader>ff :Telescope git_files<CR>
    nnoremap <leader>fu :Telescope buffers<CR>
endif

" Ag in word
nnoremap <leader>aiw :execute('Rg ' . expand("<cword>"))<CR>

" Try omnifunc, path and fallback to <c-p>
let g:SuperTabDefaultCompletionType = "context"

function! OpenSwps()
    execute "!open ~/.vim/swapfiles/"
endfunc

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
" }}}
" UI {{{
set laststatus=2                          " Always show status bar
set noshowmode                            " Dont show mode—status bars do this for us
set ruler                                 " We are using airline so this has no effect

set wildmenu                              " Shows bar above command line on wildchar press
set wildchar=<Tab>
set cmdheight=2                           " More command-line lines to help avoid 'hit-enter' prompts
set confirm                               " Use confirmation instead of failng commands

set lazyredraw                            " Execute macros faster
set timeoutlen=1000                       " Stop taking so long!
set ttimeoutlen=0

set shortmess=a                           " Use shorter labels in UI
set shortmess+=I                          " Don't give the Vim intro message
set shortmess+=T                          " Trunacte messages in middle if too long for command line

set number                                " Display line numbers

set completeopt=menuone,noinsert,noselect " Show pop up menu even when there's one match
set completeopt+=preview

set nowrap
set sidescrolloff=5                       " How many characters to keep on screen when nowrap
set scrolloff=0                           " Show context around cursor when scrolling

set splitbelow                            " More Natural splitting
set splitright

set title                                 " Set terminal title to filename

set listchars=tab:>\ ,space:-,trail:-,extends:>,precedes:<,nbsp:+,eol:$

set termguicolors                         " Use truecolorcolors

" When italics mode is entered/exited.
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" When insert|replace mode is entered|exited, change the cursor shape.
" (see help termcap-cursor-shape)
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

let challenger_deep_terminal_italics = 1
if (has('nvim'))
    colorscheme tokyonight
endif
if (!has('nvim'))
    colorscheme challenger_deep
endif

nnoremap <leader>l :setlocal list!<CR>

let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_extensions=['ale','branch', 'hunks']
let g:airline_powerline_fonts=0
let g:airline_symbols = get(g:, 'airline_symbols', {})
let g:airline_symbols.branch = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.readonly = ''
let g:airline_detect_spelllang=0
let g:airline_theme="challenger_deep"

let g:tmuxline_powerline_separators=0

let g:gitgutter_sign_removed = emoji#for('fire')
" }}}
" Mappings {{{

" Easy edit / source VIMRC
nnoremap <leader>ve :vsplit ~/src/dotfiles/.vimrc<CR>
nnoremap <leader>va :vsplit ~/src/dotfiles/.vim/bundle/vim-kieran/plugin/abbreviations.vim<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

" Git shortcuts
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>ggp :Git push<CR>
nnoremap <leader>gst :Gstatus<CR>

" Dispatch
nnoremap <leader>df :Focus make<space>
nnoremap <leader>dr :Focus!<CR>
nnoremap <leader>ds :Start<CR>

" Test
nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>tl :TestLast<CR>

" Docker tools
nnoremap <leader>kk :!kubectl apply -f %<CR>
nnoremap <leader>kd :!kubectl delete -f %<CR>

" Get the highlight colours under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Open current directory
nnoremap <leader>fn :!open .<CR><CR>

" NV
nnoremap <leader>n :NV<CR>

" Dash
nnoremap <leader>d :Dash<CR>

" }}}
let g:nv_search_paths = ['/Volumes/GoogleDrive/My\ Drive/Notes']
