" vim: set foldmethod=marker foldlevel=0 nomodeline:
set runtimepath^=$XDG_CONFIG_HOME/vim
set packpath^=$XDG_DATA_HOME/vim/site

" Text Editing {{{
set cdpath+=~/src

set undofile          " Persist undo

set clipboard=unnamedplus " Yank to system clipboard

set autoread          " Reload on external change.
set autowrite         " Auto write when navigating to different buffers.

set encoding=utf-8
set fixendofline      " Restore EOL if missing
set nobinary

set spelllang=en_gb   " English dictionary

set tabstop=2         " Use 4 spaces to indent
set shiftwidth=0      " No. of spaces to use for each indent (<<, >>, etc, 0 = tabstop).
set softtabstop=0     " What the tabs 'feel' like (0 = feature off)
set expandtab         " Use spaces to pad out a tab
set smarttab          " Tab at front of line inserts blanks according to tabstop

set autoindent        " Use indent from previous line
set smartindent       " Same as above but recognises C-like syntax (brackets et al.)

syntax enable

set formatoptions+=j  " Remove comment character when joining comments

set backspace=indent,eol,start

set nrformats-=octal  " CTRL-A does not mess with numbers starting with 0

if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

nnoremap Q @q
nnoremap Y y$
vnoremap <leader>s :sort u<CR>
cnoremap <expr> %% getcmdtype() == ':' ? './'.fnameescape(expand('%:h')).'/' : '%%'
nmap <space>sa :saveas %%

nnoremap <space>d :bd<CR>
nnoremap <space>w :w<CR>
nnoremap <space>y :let @+=expand("%")<CR>

" Use tab/shift+tab to navigate the popup window.
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
" Navigation {{{
set mouse=a

set ignorecase " Case insensitive search unless there's a mix
set smartcase
set hlsearch   " Highlight previous/current matches as they are typed
set incsearch

nnoremap <expr> N  'nN'[v:searchforward]
nnoremap <expr> n  'Nn'[v:searchforward]

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

let g:tmux_navigator_disable_when_zoomed = 1

" nnoremap <leader>l :setlocal list!<CR>

" Get the highlight colours under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}
