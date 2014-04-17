set encoding=utf-8
set fileencoding=utf-8

set tabstop=4
set shiftwidth=4
set expandtab
set background=dark

set incsearch
set nopaste
set autoindent
set fileformats=unix,dos

set comments=sr:/*,mb:*,ex:*/
syntax on
filetype on
filetype plugin on

"set hlsearch
set showmatch
set mat=2
set autoread
set ruler
set cmdheight=2
if has("mouse")
    set mouse=a
endif
set number

autocmd FileType php noremap <C-L> :!/usr/bin/env php -l %<CR>
autocmd FileType phtml noremap <C-L> :!/usr/bin/env php -l %<CR>

" Theme and custom colors
colorscheme distinguished

if has("wildmenu")
    set wildignore+=*.a,*.o
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.zip
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
    set wildmenu
    set wildmode=longest,list
endif

" Make backspace and cursor line wrap work correctly
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Set space to center screen at cursor
nmap <space> zz

" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" Remember info about open buffers on close
set viminfo^=%

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ %=%l\ /\ %L

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Buffers
nnoremap <F12> :bn<CR>
nnoremap <F10> :bp<CR>
nnoremap <F11> :BufExplorer<CR>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" BEGIN paste mode modifications
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
" END paste mode modifications
