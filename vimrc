
"
" my .vimrc, sorry, nothing fancy here
"
set nocompatible

set shiftwidth=2
set expandtab
set tabstop=4
set softtabstop=4
set showmatch
set vb
"set nu
set showcmd
"set colorcolumn=80 " vim 7.3

let mapleader=';'

syntax on

set ruler

" mostly for linux or cygwin
"
set backspace=indent,eol,start

set encoding=utf-8
set enc=utf-8
set fenc=utf-8

set smartindent
set smarttab

set history=147
set cmdwinheight=20
  " q: q/ q?

" disabling the pulldown autocomplete thinggy
inoremap <C-n> <nop>

au BufRead *.go set filetype=go
au BufRead *.md set filetype=mkd
au BufRead *.rad set filetype=radial
au BufRead *.radial set filetype=radial
au BufRead *.erb set filetype=eruby
au BufRead *.ru set filetype=ruby
au BufRead *.rake set filetype=ruby
au BufRead *.rconf set filetype=ruby

au FileType ruby set shiftwidth=2
"filetype plugin indent on
filetype on

" temp
"
"nnoremap q :%s/    /  /g<ENTER>
"nnoremap t :%s/ *$//<ENTER>
command! -nargs=0 Clean :silent %s/\v\s*$// | nohlsearch

" colors
"
colorscheme jm_green
"colorscheme jm_blue

" trailing white space highlight
"
"let ruby_space_errors=1
"let ruby_fold=1
"
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
  " from http://blog.kamil.dworakowski.name/2009/09/unobtrusive-highlighting-of-trailing.html

" Show syntax highlighting groups for word under cursor
"
" from http://vimcasts.org/episodes/creating-colorschemes-for-vim/
"
function! <SID>SynStack()

  if !exists("*synstack")
    return
  endif

  for x in map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    redi => out
    silent exe "hi" x
    redi END
    exe "hi" x
    let link = matchstr(out, ' links to \zs.*\ze$')
    if !empty(link)
      exe "hi" link
    end
  endfor

  echo '.'

endfunc

nnoremap <silent> ;s :call <SID>SynStack()<CR>

" windows
"
" horizontal
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
"
" vertical
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
"
" split
nnoremap \ :split<CR>
nnoremap @ <C-w>+
nnoremap - <C-w>-

" :q and :w
" there is also ZZ for :q
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

" home / end
"nnoremap <leader>k gg
"nnoremap <leader>j G

" replaced by DoubleSemiColon
"nnoremap <leader>; :e #<CR>

function! <SID>DoubleSemiColon()
  if exists('b:NERDTreeRoot') && winnr() == 1
    "call feedkeys("oT")
    call feedkeys("gg")
  else
    buffer #
  endif
endfunction
nnoremap <silent> <leader>; :call <SID>DoubleSemiColon()<CR>

nnoremap <silent> <leader>n :n<CR>

nnoremap <silent> <leader>c :only!<CR>

nnoremap <silent> <leader>b :buffers<CR>
nnoremap <silent> <leader>1 :e #1<CR>
nnoremap <silent> <leader>2 :e #2<CR>
nnoremap <silent> <leader>3 :e #3<CR>
nnoremap <silent> <leader>4 :e #4<CR>
nnoremap <silent> <leader>5 :e #5<CR>
nnoremap <silent> <leader>6 :e #6<CR>
nnoremap <silent> <leader>7 :e #7<CR>
nnoremap <silent> <leader>8 :e #8<CR>
nnoremap <silent> <leader>9 :e #9<CR>
nnoremap <silent> <leader>a 0w

nnoremap <silent> <leader>u :setlocal number!<CR>

inoremap <C-j> <ESC>

" nerd tree
"
" alias vit='vim -c ":NERDTreeToggle"'
"
"nnoremap <silent> <C-n> :NERDTreeToggle<CR>
"nnoremap <silent> <Nul> :NERDTreeToggle<CR>
  "<Nul> is control-space
nnoremap <silent> T :NERDTreeToggle<CR>
nnoremap <silent> ff :NERDTreeToggle<CR>
"nnoremap <silent> ff :NERDTreeFind<CR>

let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0

"function TreeOrBufferToggle()
"  if exists('b:NERDTreeRoot')
"    "NERDTreeToggle
"    call feedkeys("o")
"  else
"    if winnr() == 2 || bufnr('#') == -1 || bufnr('#') == bufnr('%')
"      NERDTreeToggle
"    else
"      buffer #
"    endif
"  endif
"endfunction
"nnoremap <silent> <space> :call TreeOrBufferToggle()<CR>
"nnoremap <silent> ;; :call TreeOrBufferToggle()<CR>

" pgup / pgdown
"
nnoremap <silent> <space> <C-d>
"nnoremap <silent> , <C-u>

" search
"
set incsearch
set hlsearch
nnoremap <silent> _ :nohlsearch<CR>

function! <SID>Grep(regex)
  exe 'vimgrep /'.a:regex.'/j ./**/*.rb'
  copen 20
endfunction
command! -nargs=1 G :call <SID>Grep('<args>')

" inspiration : http://vim.wikia.com/wiki/Find_files_in_subdirectories
"
function! <SID>Find(fragment)
  let l:result = system("find . -name '*".a:fragment."*' 2> /dev/null | head -1")
  exe 'e ' l:result
endfunction
command! -nargs=1 F :call <SID>Find('<args>')

" Ctrl-Paste
"
nnoremap <silent> <C-p> :r ! pbpaste<CR>

" Copy
"
command! -nargs=0 C :silent w ! pbcopy

nnoremap <silent> <leader>/ :w<CR>:e ~/scratch.txt<CR>

" Status bar
"
set laststatus=2
set statusline=
set statusline+=%-3.3n\ " buffer number
set statusline+=%f\ " filename
set statusline+=%h%m%r%w " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
"set statusline+=\ %{fugitive#statusline()} " fugitive
"set statusline+=\ %{rvm#statusline()} " rvm
set statusline+=%= " right align remainder
set statusline+=0x%-8B " character value
set statusline+=\ c%c%V " column
set statusline+=\ %l/%L " line
set statusline+=\ %P " file position

" Some Meta
"
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ec :e ~/.vim/colors/jm_green.vim<CR>
nnoremap <leader>sc :colorscheme jm_green<CR>
nnoremap <leader>gd :! cd ~/.vim && git diff<CR>

" Git
"
nnoremap <leader>gu :!git status<CR>
nnoremap <leader>gl :!git log --graph --oneline --abbrev-commit --decorate<CR>
nnoremap <leader>ti :!tig<CR>

