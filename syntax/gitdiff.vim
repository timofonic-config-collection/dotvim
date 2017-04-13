
" MIT licensed

hi! gdiFilename cterm=NONE ctermfg=blue ctermbg=16
hi! gdiDiffMinus cterm=NONE ctermfg=red ctermbg=16
hi! gdiDiffPlus cterm=NONE ctermfg=green ctermbg=16

syn match gdiFilename /^[^:]\+:[0-9]\+ ---+++/

syn region gdiDiffPlus start=/^+/ end="\n"
syn region gdiDiffMinus start=/^-/ end="\n"

let b:current_syntax = "gitdiff"
