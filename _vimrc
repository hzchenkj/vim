"  Vim 配置文件
"
"  author: feelinglucky<i.feelinglucky@gmail.com>
" website: http://www.gracecode.com
"    date: 2008-06-05

set tags=D:\Dev\src\jdk\tags,D:\Dev\src\hsqldb\tags

set linebreak
set textwidth=80
set nocompatible
set history=400
set ruler
set number
set hlsearch
set noincsearch
set expandtab
set noerrorbells
set novisualbell
set t_vb= "close visual bell
set foldmethod=marker
set tabstop=4
set shiftwidth=4
set nobackup
set nowritebackup
"set noswapfile
set smarttab
set smartindent
set autoindent
set cindent
set wrap
set autoread
set cmdheight=1
set showtabline=2 
"set clipboard+=unnamed
set tabpagemax=20
set laststatus=2

function! CurrectDir()
    let curdir = substitute(getcwd(), "", "", "g")
    return curdir
endfunction
set statusline=\ [File]\ %F%m%r%h\ %w\ \ [PWD]\ %r%{CurrectDir()}%h\ \ %=[Line]\ %l,%c\ %=\ %P

if has("multi_byte")
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=utf-8,gbk

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif 
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

if has("win32")
    set guifont=Courier_New:h14:cANSI
   " set guifontwide=YouYuan:h10:cGB2312
   " set guifontwide=YaHei\ Consolas\ Hybrid:h10
    au GUIEnter * simalt ~x
elseif has("unix") 
    set guifont=
    set guifontwide=
elseif has("mac") || has("macunix")
    set guifont=
    set guifontwide=
endif

if has("autocmd")
    filetype plugin indent on
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END

    function! AutoClose()
        :inoremap ( ()<ESC>i
        :inoremap " ""<ESC>i
        :inoremap ' ''<ESC>i
        :inoremap { {}<ESC>i
        :inoremap [ []<ESC>i
        :inoremap ) <c-r>=ClosePair(')')<CR>
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap ] <c-r>=ClosePair(']')<CR>
    endf

    function! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf

    "auto close for PHP and Javascript script
    au FileType php,c,python,javascript exe AutoClose()
endif

" key stock
map tn :tabnext<cr>
map tp :tabprevious<cr>

"map td :tabnew .<cr>
"map td :NERDTree <cr>
nnoremap <silent> <F3> :NERDTreeToggle<cr>
nnoremap <silent> <F4> :Calendar<cr>

map te :tabedit
map tc :tabclose<cr>
map cs :!php -l %<cr>
map bf :BufExplorer<cr>

" 日历控件配置参数
let g:calendar_diary = 'd:\Calendar'
"map ca :Calendar<cr>

if has("gui_running")
    "colorscheme desert
    "colorscheme slate
    colorscheme molokai

    set guioptions=
    set guioptions+=r
    set cursorline
else

    colorscheme dark
endif

" 配置 VimWiki 路径
let g:vimwiki_home = "d:/vimwiki/"

syntax on
" vim: set et sw=4 ts=4 sts=4 fdm=marker ff=unix fenc=utf8
