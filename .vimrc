" vim: set foldmethod=marker foldlevel=0 nomodeline:
" Plug. {{{
call plug#begin('~/.vim/bundle')
Plug '/usr/local/opt/fzf'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'direnv/direnv.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-user'
Plug 'kevinhui/vim-docker-tools'
Plug 'kshenoy/vim-signature'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'mattn/vim-textobj-url'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'rizzatti/dash.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tfnico/vim-gradle'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug '~/.vim/bundle/vim-kieran'

" Has to be loaded at the end.
Plug 'ryanoasis/vim-devicons'
call plug#end()
" }}}
" Vim Settings. {{{
" Use case insensitive search, except when using capital letters.
set ignorecase
set smartcase

" Highlight the search options.
set hlsearch
set incsearch

" Set all swap files to go to the same directory so they are not scattered everywhere.
set directory=~/.vim/swapfiles//
set backupdir=~/.vim/backupfiles//

" Set undo directory so undo persists outside of vim.
set undodir=~/.vim/undodir
set undofile

" Instead of failing a command because of unsaved changes, instead raise a dialogue asking if you wish to save changed files.
set confirm

" Set the command window height to 2 lines, to avoid many cases of having to 'press <Enter> to continue'.
set cmdheight=2

" Display line numbers on the left.
set number

" More natural tab splitting.
set splitbelow
set splitright

" Trying to yank to system clipboard.
set clipboard=unnamed

" Restore <EOL> if missing.
set nobinary
set fixendofline

" Tabs are four columns wide. Each indentation level is one tab.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Indenting
set autoindent
set smartindent

" Do not redraw when executing macros, registers / other commands.
set lazyredraw

" Apply all abbreviations, hide intro message & truncate messages.
set shortmess=aIT

" Show 5 lines above / below the cursor to show context around where I'm working.
set scrolloff=5

" Show menu even when only one option for context.
set completeopt=menuone,preview

set listchars=tab:>\ ,space:-,trail:-,extends:>,precedes:<,nbsp:+,eol:$

" Add ~/src to cd path for easy jumping between projects.
set cdpath+=~/src

" Set italic escape codes
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Set cursor shape according to mode.
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Colour scheme options.
let g:onedark_terminal_italics=1
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.light': {
  \       'allow_bold': 1,
  \       'allow_italic': 1
  \     }
  \   }
  \ }

" Colour scheme.
set termguicolors
colorscheme challenger_deep

" Enable mouse.
set mouse=a

" Join comments.
set formatoptions+=j

" Dont show mode, as status bars do a good job for us.
set noshowmode

" Automatically save before :next, :make etc.
set autoread

" Automatically reread changed files without asking me anything.
set autowrite

" Don't redraw when executing macros.
set lazyredraw
" }}}
" Mappings. {{{

" FZF shortcuts.
nnoremap <C-p> :FZF<CR>
nnoremap <leader>cd :call cd#fzf_ui()<CR>
nnoremap <leader>ff :GFiles<CR>
nnoremap <leader>fh :History:<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>ft :BTags<CR>
nnoremap <leader>fu :Buffers<CR>
nnoremap <leader>fj :call jira#fzf_ui()<CR>

imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-k> <plug>(fzf-complete-word)

" Easy edit / source VIMRC.
nnoremap <leader>ve :vsplit ~/src/dotfiles/.vimrc<CR>
nnoremap <leader>va :vsplit ~/src/dotfiles/.vim/bundle/vim-kieran/plugin/abbreviations.vim<CR>
nnoremap <leader>vb :vsplit ~/src/dotfiles/.vim/bundle/vim-kieran<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
nnoremap <leader>vu :UltiSnipsEdit<CR>

" Git shortcuts.
nnoremap <leader>ga :Git add %<CR><CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
function! s:open_branch_fzf(line)
    let l:parser = split(a:line)
    let l:branch = l:parser[0]
    if l:branch ==? '*'
        let l:branch = l:parser[1]
    endif
    execute 'Git checkout ' . l:branch
endfunction
command! -bang -nargs=0 GCheckout
            \ call fzf#vim#grep(
            \   'git branch -v', 0,
            \   {
            \     'sink': function('s:open_branch_fzf')
            \   },
            \   <bang>0
            \ )
nnoremap <leader>gco :GCheckout<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gdt :Git difftool<CR><CR>
nnoremap <leader>gdtc :Git difftool --cached<CR><CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gf :Gfetch<CR>
nnoremap <leader>ggl :Gpull<CR>
nnoremap <leader>ggp :Gpush<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gpr :!hub pull-request -r benwainwright,andrewscfc,lalkhum,cefn,saralk<CR>
nnoremap <leader>gst :Gstatus<CR>
nnoremap <leader>gx :GV<CR>

" Show / hide the hidden characters.
nnoremap <leader>l :setlocal list!<CR>

" Toggle relativenumber.
nnoremap <leader>n :call NumberToggle()<CR>

" Sort a selection.
vnoremap <leader>s :sort u<CR>

" Remove highlight.
nnoremap <leader>o :noh<CR>

" Dispatch.
nnoremap <leader>df :Focus

" Test.
nnoremap <leader>t :TestNearest<CR>
nnoremap <leader>T :TestFile<CR>

" Jira commands.
nnoremap <leader>jb :call jira#browse(jira#ticketFromBranch())<CR><CR>
nnoremap <leader>jc :call jira#comment(jira#ticketFromBranch())<CR>

" Sneak.
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T

" Saner 'n' directions.
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" Make Y behave like other capitals.
nnoremap Y y$

" qq to record, Q to replay.
nnoremap Q @q

" Ag in word
nnoremap <leader>aiw :execute('Ag ' . expand("<cword>"))<CR>

" Last inserted text
nnoremap g. :normal! `[v`]<cr><left>

" Delete current buffer.
nnoremap <leader>x :bd<CR>

" Insert current dir into command line when %% is pressed.
cnoremap <expr> %% getcmdtype() == ':' ? fnameescape(expand('%:h')).'/' : '%%'

" Docker tools.
nnoremap <leader>dkp :DockerToolsToggle<CR>

" Escape terminal with normal <esc> key.
tnoremap <Esc> <C-\><C-n>

" Get the highlight colours under the cursor.
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Open current directory
nnoremap <leader>fn :!open .<CR><CR>

" }}}
" Functions. {{{
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

function! OpenSwps()
    execute "!open ~/.vim/swapfiles/"
endfunc

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

function! GoyoEnter()
    Limelight
    execute 'match ErrorMsg /\%81v.\+/'
    silent !tmux set status off
endfunction

function! GoyoLeave()
    Limelight!
    call clearmatches()
    silent !tmux set status on
endfunction
" }}}
" {{{ Autocmd.
" Highlight trailing spaces
augroup vimrc
    autocmd!

    " File types.

    autocmd BufNewFile,BufRead *.conf setfiletype nginx
    autocmd BufNewFile,BufRead *.hbs setfiletype html
    autocmd BufNewFile,BufRead *.json.dist setfiletype json
    autocmd BufNewFile,BufRead *.mustache setfiletype html
    autocmd BufNewFile,BufRead *.puml setfiletype plantuml
    autocmd BufNewFile,BufRead *.spv setfiletype dockerfile
    autocmd BufNewFile,BufRead .Brewfile setfiletype ruby
    autocmd BufNewFile,BufRead .ctags setfiletype ctags
    autocmd BufNewFile,BufRead .env.* setfiletype yaml
    autocmd BufNewFile,BufRead .npmrc setfiletype dosini
    autocmd BufNewFile,BufRead .tern-project setfiletype json
    autocmd BufNewFile,BufRead Brewfile setfiletype ruby
    autocmd BufNewFile,BufRead Dockerfile.* setfiletype dockerfile
    autocmd BufNewFile,BufRead Jenkinsfile setfiletype groovy
    autocmd BufNewFile,BufRead Jenkinsfile.* setfiletype groovy
    autocmd BufNewFile,BufRead config setfiletype dosini
    autocmd BufNewFile,BufRead hub setfiletype yaml

    " Highlight whitespace.
    autocmd InsertEnter * match ErrorMsg /\s\+\%#\@<!$/
    autocmd BufWinEnter,InsertLeave * match ErrorMsg /\s\+$/
    autocmd BufWinLeave * call clearmatches()

    " Remove whitespace.
    autocmd BufWritePre * :call StripTrailingWhitespaces()

    " Override tabs/spaces.
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    autocmd FileType javascript,json,javascript.jsx,ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

    " Set spelling / linebreak for text files.
    autocmd FileType gitcommit,markdown,plantuml,conf setlocal spell
    autocmd FileType gitcommit,markdown,conf setlocal linebreak
    autocmd FileType gitcommit,markdown,conf setlocal textwidth=80 colorcolumn=80

    " Emoji for text files.
    autocmd FileType gitcommit,markdown setlocal omnifunc=emoji#complete

    " When entering/exiting Goyo, turn Limelight on / off.
    autocmd! User GoyoEnter nested call GoyoEnter()
    autocmd! User GoyoLeave nested call GoyoLeave()

augroup end
" }}}
" Plugins. {{{
" Airline/Tmuxline.
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

let g:airline_extensions=['ale','branch', 'hunks']

let g:airline_powerline_fonts=0
let g:tmuxline_powerline_separators=0

let g:airline_symbols = get(g:, 'airline_symbols', {})
let g:airline_symbols.branch = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.readonly = ''

let g:airline_theme="challenger_deep"

" Dont conceal quotes when viewing JSON.
let g:vim_json_syntax_conceal=0

" Set the Ultisnips directory.
let g:UltiSnipsSnippetsDir='~/.vim/ultisnips'

" Set the Ultisnips edit window to split vertically.
let g:UltiSnipsEditSplit="vertical"

" Ack to use Ag.
let g:ackprg='ag --vimgrep --hidden'
let g:ack_use_dispatch=1

" Test strategy is Dispatch.
let test#ruby#use_binstubs = 0
let test#strategy = "dispatch"

" Sneak config.
let g:sneak#label = 1
highlight! link Sneak Search
highlight! link SneakScope Search

" ALE.
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:ale_linters={
            \'python':['flake8', 'mypy', 'pylint', 'pyls2']
            \}
let g:ale_python_pyls_use_global = 1

highlight! link ALEWarningSign ALEWarning

" Gitgutter.
let g:gitgutter_sign_removed = emoji#for('fire')

" Dash.
let g:dash_map = { 'yaml': ['cloudformation'] }

set formatoptions+=j
" }}}
