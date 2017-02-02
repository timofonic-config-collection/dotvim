
" MIT license

" Quit when a (custom) syntax file was already loaded
"if exists("b:current_syntax")
"  finish
"endif

"syn case match

"syn match flBinaryFilename '^Binary file .\+ matches'
"hi def link flBinaryFilename Special
"syn match flBf '^Binary file'
"hi def link flBinaryFilename Normal

"syn match groTitle '^== .\+'
"syn match groFilename '[^\/]\+$'
"syn match groFilename 'core'
"syn match groLineNr '\d\+:'
syn match lioFilename '/[^/]\+$'

"echo "syn match groPattern " . g:groPattern
"exe "syn match groPattern " . g:groPattern

let b:current_syntax = "showtreeout"

