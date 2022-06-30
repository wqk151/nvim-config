" ref: https://www.chrisatmachine.com/Neovim/02-vim-general-settings/
syntax enable
" 鼠标可以移动，调整窗口等
set mouse-=a
" 超过 window 宽度的行不要折叠
set nowrap
" 自动进入到新打开的窗口
set splitbelow
set splitright

" tab相关变更
" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab
" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set expandtab
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回
set t_ti= t_te=
" 打开行号
set number
" 显示当前的行号列号
set ruler
hi! link SignColumn   LineNr
" 高亮光标所在行
"开启光亮光标行(black, brown, grey, blue, green, cyan, magenta, yellow, white)
set cursorline
hi CursorLine cterm=NONE ctermbg=blue ctermfg=yellow guibg=red guifg=white
"开启高亮光标列
set cursorcolumn
hi CursorColumn cterm=NONE ctermbg=brown ctermfg=white
set termguicolors
" 因为失去焦点就会自动保存，所以没有必要使用 swapfile
set noswapfile
" 让退出 vim 之后 undo 消息不消失
set undofile
" 只有一个全局 status line，而不是每一个 window 一个
set laststatus=3
" 当打开文件的时候，自动进入到上一次编辑的位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" 当文件被其他编辑器修改时，自动加载
set autoread
au FocusGained,BufEnter * :checktime
" 当失去焦点或者离开当前的 buffer 的时候保存
set autowrite
autocmd FocusLost,BufLeave * silent! update
" 在 terminal 中也是使用 esc 来进入 normal 模式
tnoremap  <Esc>  <C-\><C-n>
" 映射 leader 键为 ,
let g:mapleader = ','
" 设置主题，最下面的会生效
colorscheme tokyonight

let g:everforest_background = 'hard'
colorscheme everforest

colorscheme gruvbox

" colorscheme dracula
" set t_Co=256

" 将 q 映射为 <leader>q，因为录制宏的操作比较少，而关掉窗口的操作非常频繁
noremap <leader>q q

" 访问系统剪切板
map <leader>y "+y
map <leader>p "+p
map <leader>d "+d

" 设置文内智能搜索提示
" 高亮search命中的文本
set hlsearch
" 打开增量搜索模式,随着键入即时搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 有一个或以上大写字母时仍大小写敏感
set smartcase

"==========================================
" 自定义快捷键设置
"==========================================
" 主要按键重定义

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" 显示当前的行号(普通模式为相对)：
augroup CursorLineOnlyInActiveWindow
    autocmd!
    " 离开插入模式时
    autocmd InsertLeave * setlocal relativenumber signcolumn=auto
    " 进入插入模式时
    autocmd InsertEnter * setlocal norelativenumber signcolumn=number
    " 进入缓冲区后
    autocmd BufEnter * setlocal cursorline relativenumber signcolumn=auto
    " 离开缓冲区后
    autocmd BufLeave * setlocal nocursorline norelativenumber signcolumn=number
augroup END

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

" F2 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
function! HideNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc
nnoremap <F2> :call HideNumber()<CR>

set pastetoggle=<F3>
" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" toggle vista navigator
map <F9> :Vista!!<CR>

" Automatically set paste mode in Vim when pasting in insert mode
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" nvim-tree
map <F4> :NvimTreeToggle<CR>

" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Go to home and end using capitalized directions
noremap H ^
noremap L $

" Map ; to : and save a million keystrokes 用于快速进入命令行
nnoremap ; :

" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" 搜索相关
" map <space> /
" 进入搜索Use sane regexes"
nnoremap / /\v
vnoremap / /\v

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 去掉搜索高亮
noremap <silent><leader>/ :nohls<CR>

" switch # *
nnoremap # *
nnoremap * #

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

" 选中并高亮最后一次插入的内容
nnoremap gv `[v`]

" select block
nnoremap <leader>v V`}

" kj 替换 Esc
inoremap kj <Esc>

" Quickly close the current window
nnoremap <leader>q :q!<CR>

" Quickly save the current file
nnoremap <leader>w :w!<CR>

" w!! to sudo & write a file
" cmap w!! w !sudo tee >/dev/null %

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" 编辑完成后跳出括号
inoremap ,, <Esc>la
" inoremap .. <Esc>2la
"
"==========================================
" FileType Settings  文件类型设置
"==========================================
" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py,*.go exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    if &filetype == 'sh'
        call setline(1,  "\#!/bin/bash")
        call append(".",         "\#####################################################")
        call append(line(".")+1, "\#  > File Name: ".expand("%"))
        call append(line(".")+2, "\#  > Author: wqk")
        call append(line(".")+3, "\#  > mail: wqk@datatang.com")
        call append(line(".")+4, "\#  > Created Time: ".strftime("%c"))
        call append(line(".")+5, "\#####################################################")
        call append(line(".")+6, "")
    elseif &filetype == 'python'
        call setline(1, "#!/usr/bin/env python")
        call append(line("."), "# -*- coding:utf-8 -*-")
        call append(line(".")+1, "\#####################################################")
        call append(line(".")+2, "\#  > File Name: ".expand("%"))
        call append(line(".")+3, "\#  > Author: wqk")
        call append(line(".")+4, "\#  > Mail:  wqk@datatang.com")
        call append(line(".")+5, "\#  > Created Time: ".strftime("%c"))
        call append(line(".")+6, "\#  > Version: python 3.7")
        call append(line(".")+7, "\######################################################")
        call append(line(".")+8,"")
    elseif &filetype == 'go'
        call setline(1, "\//####################################################")
        call append(line("."),   "\// > File Name: ".expand("%"))
        call append(line(".")+1, "\// > Author: wqk")
        call append(line(".")+2, "\// > Mail:  wqk@datatang.com")
        call append(line(".")+3, "\// > Created Time: ".strftime("%c"))
        call append(line(".")+4, "\// > Version: gloang 1.14")
        call append(line(".")+5, "\//######################################################")
        call append(line(".")+6,"")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc

" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" disable showmatch when use > in php
au BufWinEnter *.php set mps-=<:>

" https://stackoverflow.com/questions/25227281/how-to-auto-highlight-the-current-word-in-vim
" Highlight the symbol and its references when holding the cursor."
function! HighlightWordUnderCursor()
    let disabled_ft = ["qf", "fugitive", "nerdtree", "gundo", "diff", "fzf", "floaterm"]
    if &diff || &buftype == "terminal" || index(disabled_ft, &filetype) >= 0
        return
    endif
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        " hi MatchWord cterm=undercurl gui=undercurl guibg=#3b404a
        hi MatchWord guibg=#575e6b
        exec 'match' 'MatchWord' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction

augroup MatchWord
  autocmd!
  autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()
augroup END

" 加载各种插件的配置, 参考 https://github.com/jdhao/nvim-config
let s:core_conf_files = [
      \ 'misc.vim',
      \ 'coc.vim',
      \ 'debug.vim',
      \ 'ccls.vim',
      \ 'wilder.vim',
      \ 'startify.vim',
      \ 'airline.vim',
      \ ]

" \ 'airline.vim',
for s:fname in s:core_conf_files
  execute printf('source %s/vim/%s', stdpath('config'), s:fname)
endfor

" 加载 lua 配置
lua require 'plugins'
lua require 'buffer-config'
lua require 'orgmode-config'
lua require 'telescope-config'
lua require 'tree-config'
lua require 'whichkey-config'
lua require 'code-runner-config'
lua require 'colorizer'.setup{'css'; 'javascript'; 'vim'; html = { mode = 'foreground';}}
lua require('nvim-autopairs').setup{}
