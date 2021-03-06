
" MIT licensed

" Quit when a (custom) syntax file was already loaded
"if exists("b:current_syntax")
"  finish
"endif

hi! stoFilename cterm=NONE ctermfg=green ctermbg=16
hi! stoDirname cterm=NONE ctermfg=darkgreen ctermbg=16
hi def link stoTree Comment
hi def link stoSummary Comment

syn match stoSummary '\v^\d+ .+$'

syn match stoLine '\v[├│└─  ]+ .+' contains=stoTree,stoFilename,stoDirname
syn match stoTree '\v^[├│└─  ]+' contained
syn match stoFilename '\v[^ \/]+$' contained
syn match stoDirname '\v[^ \/]+\/$' contained
syn match stoDirname '\v^[a-zA-Z].*$'

let b:current_syntax = "showtreeout"

