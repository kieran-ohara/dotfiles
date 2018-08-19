" vim: set foldmethod=marker foldlevel=0 nomodeline:
" Plug. {{{
call plug#begin('~/.vim/bundle')
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'direnv/direnv.vim'
Plug 'dracula/vim'
Plug 'edkolev/tmuxline.vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'janko-m/vim-test'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-user'
Plug 'kshenoy/vim-signature'
Plug 'larsbs/vimterial'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'mattn/vim-textobj-url'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox'
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
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug '~/.vim/bundle/vim-kieran'
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
let g:onedark_terminal_italics=1

" Set cursor shape according to mode.
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Colour scheme.
set termguicolors
set background=dark
colorscheme onedark

" Enable mouse.
set mouse=a
" }}}
" Mappings. {{{

" Dirvish
nnoremap <C-n> :Dirvish<CR>

" FZF shortcuts.
nnoremap <C-p> :FZF<CR>
nnoremap <leader>cd :call fzf#run({'sink': 'cd', 'source': 'ls', 'dir': '~/src/', 'down': '40%'})<CR>
nnoremap <leader>ff :GFiles<CR>
nnoremap <leader>fh :History:<CR>
nnoremap <leader>fj :call JiraFzf()<CR>
nnoremap <leader>fl :Lines<Space>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fp :Maps<CR>
nnoremap <leader>ft :BTags<CR>
nnoremap <leader>fu :Buffers<CR>

" Easy edit / source VIMRC.
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
nnoremap <leader>va :vsplit ~/src/dotfiles/bundle/myvim/plugin/abbreviations.vim<CR>
nnoremap <leader>vb :vsplit ~/src/dotfiles/bundle/myvim<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
nnoremap <leader>vu :UltiSnipsEdit<CR>

" Git shortcuts.
nnoremap <leader>ga :Git add %<CR><CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gco :Git checkout<space>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gdt :Git difftool<CR><CR>
nnoremap <leader>gdtc :Git difftool --cached<CR><CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gf :Gfetch<CR>
nnoremap <leader>ggl :Gpull<CR>
nnoremap <leader>ggp :Gpush<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gpr :!hub pull-request<CR>
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
nnoremap <leader>jb :call jira#browse()<CR><CR>
nnoremap <leader>jc :call jira#comment()<CR>

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

" Readline style key binding in command-line.
cnoremap <C-A> <Home>

" Dash shortcuts
nmap <silent> <leader>h <Plug>DashSearch
nmap <silent> <leader>H <Plug>DashGlobalSearch

" Delete current buffer.
nnoremap <leader>x :bd<CR>
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

function! GoogleIt()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    let selection = join(lines, "\n")
	echom selection
    execute '!open "http://www.google.co.uk/search?q=' . selection .'"'
endfunction

function! CosmosBrowseService()
    let filename=system('echo ${$(pwd)##*/}')
    let url="https://admin.live.bbc.co.uk/cosmos/services/" . filename
    execute "!open " . url
endfunction

function! JiraIssueFromString(issue)
    let split = split(a:issue, ":")
    return split[0]
endfunction

function! JiraEdit(issue)
    execute "!jira edit " . JiraIssueFromString(a:issue)
endfunction

function! JiraBrowse(issue)
    execute "!jira browse " . JiraIssueFromString(a:issue)
endfunction

function! JiraView(issue)
    " Get the issue.
    let issue = system("jira view " . JiraIssueFromString(a:issue))

    " Open a new split and set it up.
    vsplit __jira_issue__
    normal! ggdG
    setlocal filetype=yaml
    setlocal buftype=nofile

    " Insert the issue.
    call append(0, split(issue, '\v\n'))
endfunction

function! JiraFzf()
    call fzf#run({'source': 'jira orbiten',
                \ 'options': '-d:
                \ --preview "jira view {1} -t fzf_preview"
                \ --preview-window top:wrap
                \ --expect=ctrl-r,ctrl-e',
                \ 'sink*': function('HandleJiraKeys')})
endfunction

function! HandleJiraKeys(lines)
    let cmd = get({'ctrl-r': 'JiraBrowse', 'ctrl-e': 'JiraEdit'}, a:lines[0], 'JiraView')
    let issue = a:lines[1]
    let Fn = function(cmd)
    call Fn(issue)
endfunction

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
    silent !tmux set status off
endfunction

function! GoyoLeave()
    Limelight!
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
    autocmd FileType javascript,json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

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
" Airline.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_extensions=['ale','branch','obsession']
let g:airline_powerline_fonts=1
let g:airline_theme="onedark"

" Dont conceal quotes when viewing JSON.
let g:vim_json_syntax_conceal=0

" Set the Ultisnips directory.
let g:UltiSnipsSnippetsDir='~/.vim/ultisnips'

" Set the Ultisnips edit window to split vertically.
let g:UltiSnipsEditSplit="vertical"

" Ack to use Ag.
let g:ackprg='ag --vimgrep --hidden'

" Test strategy is Dispatch.
let test#strategy = "dispatch"

" Sneak config.
let g:sneak#label = 1
highlight! link Sneak Search
highlight! link SneakScope Search

" ALE.
let g:ale_sign_error = emoji#for('balloon')
let g:ale_sign_warning = emoji#for('space_invader')
highlight! link ALEErrorSign SignColumn
highlight! link ALEWarningSign SignColumn

" Gitgutter.
let g:gitgutter_sign_removed = emoji#for('fire')

" Dash.
let g:dash_map = { 'yaml': ['cloudformation'] }
" }}}
