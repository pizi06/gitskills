set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')


" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" yinpilei
" 显示行号
set nu

" 折叠{{{}}}
set foldmethod=marker

" 自动缩进
set autoindent
"set cindent
set cindent
set cinkeys-=0#
set indentkeys-=0#

" Tab键的宽度
set tabstop=4

" 统一缩进为4
set softtabstop=4
set shiftwidth=4

" 空格代替制表符
set expandtab

" 搜索忽略大小写
set ignorecase

"搜索逐字符高亮
set hlsearch
set incsearch

"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

" 高亮显示匹配的括号
set showmatch

" 100
set cc=100

set columns=130
set lines=80
color desert
set go= "“无菜单、工具栏”

set nobackup      " do not keep a backup file, use versions instead

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 用红色标记多余空白
highlight BadWhitespace ctermbg=red guibg=red

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
autocmd BufRead *.py nmap <F5> :!python %<CR>

" tab键自动补全python
filetype plugin on
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'
"defalut g:pydiction_menu_height == 15
"let g:pydiction_menu_height = 20

" Check the syntax of a python file
function! CheckPythonSyntax()
    if &filetype != 'python'
        echohl WarningMsg | echo 'This is not a Python file !' | echohl None
        return
    endif
    setlocal makeprg=python\ -u\ %
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
   echohl WarningMsg | echo 'Syntax checking output:' | echohl None
   if &modified == 1
       silent write
   endif
   exec "silent make -c \"import py_compile;py_compile.compile(r'".bufname("%")."')\""
    clist
endfunction
au filetype python map <F6> :call CheckPythonSyntax()<CR>
au filetype python imap <F6> <ESC>:call CheckPythonSyntax()<CR>


" set guifont=Source\ Code\ Pro:h11
set guifont=Monaco:h11

if has("multi_byte")
"    " UTF-8 编码
"    set encoding=utf-8
"    set termencoding=utf-8
"    set formatoptions+=mM
"    set fencs=utf-8,gbk
"    if v:lang =~? '^/(zh/)/|/(ja/)/|/(ko/)'
"        set ambiwidth=double
"    endif
    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

"很多插件都会要求的配置检测文件类型
:filetype on
:filetype plugin on
:filetype indent on
"下边这个很有用可以根据不同的文件类型执行不同的命令
"例如：如果是c/c++类型
:autocmd FileType c,cpp : set foldmethod=marker
:autocmd FileType c,cpp :set number
:autocmd FileType c,cpp :set cindent
"例如：如果是python类型
:autocmd FileType python :set number
:autocmd FileType python : set foldmethod=marker
:autocmd FileType python :set smartindent

let python_highlight_all=1
syntax on

"auto add pyhton header --start
autocmd BufNewFile *.py 0r ~/.vim/template/python/pythonconfig.py
""""""" pythonconfig.py content """""""""""
" # -*- coding:utf-8 -*-
" '''
" Created on 
" 
" @author: yinpilei
" '''

" autocmd BufNewFile *.py ks|call FileName()|'s
autocmd BufNewFile *.py ks|call CreatedTime()|'s

" fun FileName()
"     if line("$") > 10
"         let l = 10  "这里是字母L 不是数字1 
"     else
"         let l = line("$")
"     endif 
"     exe "1," . l . "g/File Name:.*/s/File Name:.*/File Name: " .expand("%")  
"     "最前面是数字1，这里的File Name: 要和模板中一致
" endfun 

fun CreatedTime()
    if line("$") > 10
        let l = 10
    else
        let l = line("$")
    endif 
    exe "1," . l . "g/Created On.*/s/Created On.*/Created On " .strftime("%Y年%m月%d日") 
    "这里Create Time: 要和模板中一致
endfun 
"auto add python header --end

"""""""""""""""""""""""""""""""Bundle"""""""""""""""""""""""""
Bundle 'taglist.vim'
let Tlist_Ctags_Cmd='ctags'
let Tlist_Show_One_File=1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_WinWidt =28                    "设置taglist的宽度
let Tlist_Exit_OnlyWindow=1 "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window=1 "在右侧窗口中显示taglist窗口
let Tlist_Use_Left_Windo =1                "在左侧窗口中显示taglist窗口


Bundle 'scrooloose/nerdtree'
"F2开启和关闭树"
map <F2> :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
"显示书签"
let NERDTreeShowBookmarks=1
"设置忽略文件类型"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
"窗口大小"
let NERDTreeWinSize=25


Bundle 'bling/vim-airline'
set laststatus=2

Plugin 'scrooloose/syntastic'
Bundle 'nvie/vim-flake8'
let g:flake8_ignore="E501"
" Bundle 'PyCQA/flake8'
" autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
" let g:flake8_quickfix_location="topleft"
" let g:flake8_quickfix_height=7
" Distinct highlighting of keywords vs values, JSON-specific (non-JS)
" warnings, quote concealing
" TODO 导致ctrl n 不能补全，先注释掉，有空再整 
" Plugin 'https://github.com/elzr/vim-json'
" let g:vim_json_syntax_conceal = 0
" let g:indentLine_noConcealCursor=""
" :setlocal foldmethod=syntax

Bundle 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

Bundle 'leafgarland/typescript-vim'
let g:typescript_indent_disable = 1
let g:typescript_compiler_options = '-sourcemap'
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

Plugin 'ctrlpvim/ctrlp.vim'

" Bundle 'Valloric/YouCompleteMe'
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" yinpilei
