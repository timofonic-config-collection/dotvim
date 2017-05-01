
function! s:ListFiles()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if bufnr('==ListFiles') > 0 | exe 'bwipeout! ==ListFiles' | endif
    " close previous ListFiles if any

  exe 'new | only'
    " | only makes it full window
  exe 'file ==ListFiles'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  exe 'setlocal filetype=ListFiles'

  exe 'let @z=""'
  exe 'redir @z'
  exe 'silent echo "== buffers"'
  exe 'silent buffers'
  exe 'redir END'
  exe 'silent $put z'

  if filereadable('.errors') && getfsize('.errors') > 0
    exe 'let @z=""'
    exe 'redir @z'
    exe 'silent echo "== .errors"'
    exe 'redir END'
    exe 'silent $put z'
    exe 'r .errors'
  endif

  exe 'let @z=""'
  exe 'redir @z'
  exe 'silent echo "== git status"'
  exe 'redir END'
  exe 'silent $put z'
  exe 'r! (echo "`git status`"; echo "`git diff --stat`") | perl ~/.vim/scripts/restatus.pl'

  let l = line('.') + 1
  exe 'let @z=""'
  exe 'redir @z'
  exe 'silent echo "== recent"'
  exe 'silent oldfiles'
  exe 'redir END'
  exe 'silent $put z'
  "
  exe '' . l . ',g/greprout/d_'
  exe '' . l . ',g/showtreeout/d_'
    " don't show recent .greprout or .showtreeout files (they're gone)

  exe '%s/^\s\+\d\+[^\"]\+"//'
  exe '%s/"\s\+line /:/'

  exe 'g/COMMIT_EDITMSG/d_'
  exe 'g/NetrwTreeListing/d_'
  exe 'g/bash-fc-/d_'
  exe 'g/==ListFiles/d_'
  exe 'g/==GitBlame/d_'
  exe 'g/==GitDiff/d_'
  exe 'g/==GitLog/d_'
  exe 'g/\/private\/var\//d_'
  exe 'g/\/mutt-/d_'
    " hide a set well known temp files

  exe 'silent %s/^[0-9]\+: //'

  exe '%sno#^' . fnamemodify(expand("."), ":~:.") . '/##'
    " shorten paths if in a current dir subdir

  exe 'g/^$/d_'
  exe '%s/^==/

  "call search('== recent')
  "let l = line('.') + 1
  "exe '' . l . ',$sort u'
    " sort recent files

  call feedkeys('1G')
  call feedkeys(":call search('^[\.\/a-zA-Z0-9]', '')\r:echo\r")
    " go to first file

  setlocal syntax=listfiles

  nmap <buffer> o gF
  nmap <buffer> <space> gF
  nmap <buffer> <CR> gF

  nmap <buffer> v /

  nmap <buffer> rr :call search('^== \.errors', '')<CR>:echo<CR>jll
    " silently go to "== .errors" well... the commands appear downstairs...

  nmap <buffer> a :call search('^== ', '')<CR>:echo<CR>0
  nmap <buffer> A :call search('^== ', 'b')<CR>:echo<CR>0
    " silently go to next "== "

  nmap <buffer> gl :call search('^== buffers', '')<CR>}k
    " silently go to last file in buffer
    " reminder type "}" to go to next blank line... See also "{", ")" and "("
endfunction " ListFiles

command! -nargs=0 ListFiles :call <SID>ListFiles()
nnoremap <silent> <leader>b :call <SID>ListFiles()<CR>
