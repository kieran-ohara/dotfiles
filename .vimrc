" vim: set foldmethod=marker foldlevel=0 nomodeline
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

syntax enable

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


nnoremap <leader>w :w<CR>

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

function! OpenSwps()
    execute "!open ~/.vim/swapfiles/"
endfunc
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


nnoremap <leader>l :setlocal list!<CR>
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

" Kube tools
nnoremap <leader>kk :!kubectl apply -f %<CR>
nnoremap <leader>kd :!kubectl delete -f %<CR>

" Get the highlight colours under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Open current directory
nnoremap <leader>fn :!open .<CR><CR>
" }}}
