function! s:EnsureSpellFile()
  let l:plugin_dir = fnamemodify(expand('<script>:p:h'), ':h')  " Go up one directory
  let l:spell_dir = l:plugin_dir . '/spell'
  let l:spell_file = l:spell_dir . '/en.utf-8.add'
  let l:spell_spl = l:spell_file . '.spl'

  " Create .spl file if it doesn't exist or is older than .add file
  if !filereadable(l:spell_spl) || getftime(l:spell_spl) < getftime(l:spell_file)
    echom "Creating spell file"
    execute 'silent mkspell! ' . l:spell_file
  endif

  " Set spellfile option
  let &spellfile = l:spell_file
endfunction

" Call the function when spell checking is enabled, either globally or
" locally.
augroup ConfigSpell
  autocmd!
  " Listen for spell option being set, either globally or locally
  autocmd OptionSet spell call s:EnsureSpellFile()
  " Listen for spell option being set locally via setlocal
  autocmd BufEnter * if &l:spell | call s:EnsureSpellFile() | endif
augroup END
