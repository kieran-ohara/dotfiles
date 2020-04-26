" Vim compiler file
"
" Compiler:	Jest-Cli
" Maintainer:	Craig Dallimore <decoy9697@gmail.com>, Kieran Bamforth
" Last Change:	2020 April 26

if exists("current_compiler")
  finish
endif
let current_compiler = "jest-cli"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=%.%#\ at\ %f:%l:%c,%.%#\ at\ %.%#(%f:%l:%c)
CompilerSet makeprg=node_modules/.bin/jest
