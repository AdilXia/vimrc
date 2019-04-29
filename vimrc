" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible


" set vundles configs in ~/.vimrc.bundles
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

syntax on   "语法高亮
filetype indent on  "依据文件类型选择对齐方式，如.py文件，Vim 就会找Python的缩进规则~/.vim/indent/python.vim
filetype plugin on  "载入文件类型插件


"""""""""""""""Appearence"""""""""""""""
set nu          "显示行号， set nonu手动关闭
set showmode    "底部显示 当前为插入模式还是命令模式
set showcmd     "命令模式下底部显示 当前键入的命令
set cursorline  "光标所在行高亮
"set mouse=a   "启用鼠标 鼠标选中从复制变为选中,开启后shift + 鼠标选中表示复制
set wrap        "自动折行，即太长的行分成几行显示, set nowrap手动关闭
set linebreak   "只有遇到指定的符号（比如空格、连词号和其他标点符号），才发生折行
set wrapmargin=2 "指定折行处与编辑窗口的右边缘之间空出的字符数
set laststatus=2 "是否显示状态栏0 表示不显示，1 表示只在多窗口时显示，2 表示显示
set ruler      "在状态栏显示光标的当前位置（位于哪一行哪一列）

"""""""""""""""Search"""""""""""""""
set showmatch   "光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
set hlsearch    "高亮搜索 快捷键 : * or shift + #
set incsearch   "输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果
set ignorecase  "搜索时忽略大小写
set smartcase   "对于只有一个大写字母的搜索词，将大小写敏感；其他情况都是大小写不敏感


""""""""""""""" Edit """""""""""""""
"set spell spelllang=en_us   "打开英语单词的拼写检查
set autoread    "设置当文件被改动时自动载入
set history=1000            "Vim 需要记住多少次历史操作
set langmenu=zh_CN.UTF-8
set completeopt=preview,menu    "代码补全
set confirm "在处理未保存或只读文件的时候，弹出确认
set autowrite   "自动保存


""""""""""""""""Indentation""""""""""""""""""""""
set autoindent  "按下回车键后，下一行的缩进会自动跟上一行的缩进保持一致
set smartindent "输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果

set tabstop=4   "按下Tab时，Vim 显示的空格数
set shiftwidth=4    "命令模式>>（增加一级缩进）、<<（取消一级缩进）或者==（取消全部缩进）时，每一级的字符数
set expandtab   "由于Tab键在不同的编辑器缩进不一致，该设置自动将Tab转为空格
set softtabstop=4   "Tab转为多少个空格
set smarttab


"set for terminal"
set viminfo+=! "keep globa varible
set term=xterm
set t_Co=256
set background=dark
let g:molokai_original = 1

"markdown配置
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{go}   set filetype=go
au BufRead,BufNewFile *.{js}   set filetype=javascript

".vimrc发生变化时，重新加载
autocmd! bufwritepost .vimrc source ~/.vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘映射
"""""""""""""""""""""""""""""""""""""""""""""""""""""
"F1 Help信息
"F2列出当前目录文件
map <F2> :NERDTreeToggle<CR>
imap <F2> <ESC> :NERDTreeToggle<CR>
nmap <F3> :call Kernel_style()<CR>
"F5 C\C++编译运行
"F6 代码格式化
"F8打开Tagbar(代替:Tlist)
nmap <F8> :TagbarToggle<CR>
"let mapleader="\<Space>"
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
"相当于mru功能，show recently opened files
map <leader>fp :CtrlPMRU<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""
"皮肤插件 暗系皮肤，你值得拥有
colorscheme molokai

"NERDTree插件 当打开vim且没有文件时自动打开目录树
autocmd vimenter * if !argc() | NERDTree | endif

"ctrlp插件配置
"按下 Ctrl + p 快捷键，输入文件名。 所有和这个文件名匹配的文件都会被按照优先级列出来，按下 enter 或者 Ctrl + t 就可以在当前 buffer 或者新 tab 页打开你要的文件了。
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" 设置过滤不进行查找的后缀名
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'

"YouCompleteMe插件配置
" 设置跳转到方法/函数定义的快捷键
nnoremap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 触发补全快捷键
let g:ycm_key_list_select_completion = ['<TAB>', '<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<c-p>', '<Up>']
let g:ycm_auto_trigger = 1
" 最小自动触发补全的字符大小设置为 3
let g:ycm_min_num_of_chars_for_completion = 3
" YCM的previw窗口比较恼人，还是关闭比较好
set completeopt-=preview

"syntastic插件配置
"安装pathogen:mkdir -p ~/.vim/autoload && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
execute pathogen#infect()
let g:syntastic_python_checkers=['pylint']
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']

"ag插件配置
" specify a custom ag name and path
"let g:ag_prg="/home/qin --vimgrep"

"airline插件配置
" Buffer用法介绍
"1. vim a.c b.c 打开多个文件便可以把它们都放入Buffer 或通过:e[dit]命令即可打开某个文件到缓冲区
"2. Ctrl+^来切换当前缓冲区和上一个缓冲区, 或者:bn[ext] 下一个缓冲区 :bp[revious] 上一个缓冲区 :b {number, expression} 跳转到指定缓冲区
"3. :b <Tab> "显示所有Buffer中的文件
"4. :sb 3 水平分屏打开编号为3的Buffer :vertical sb 3 垂直分屏打开编号为3的Buffer
"打开tabline功能,方便查看Buffer和切换
let g:airline#extensions#tabline#enabled = 1
"Separators
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"Buffer formatters
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_detect_spell=1

" YankRing
nmap <Leader>ys :YRShow<CR>
nmap <Leader>yc :YRClear<CR>


"""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
"""""""""""""""""""""""""""""""""""
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func! SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!/bin/sh")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")
    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
    elseif &filetype == 'c'
        call setline(1, "/*")
        call append(line("."), "* =====================================================================================")
        call append(line(".")+1, "* ")
        call append(line(".")+2, "*       Filename:  ".expand("%"))
        call append(line(".")+3, "* ")
        call append(line(".")+4, "*    Description:  ")
        call append(line(".")+5, "* ")
        call append(line(".")+6, "*        Version:  1.0")
        call append(line(".")+7, "*        Created:  ".strftime("%c"))
        call append(line(".")+8, "*       Compiler:  gcc")
        call append(line(".")+9, "* ")
        call append(line(".")+10, "*         Author:  ")
        call append(line(".")+11, "*        Company:  ")
        call append(line(".")+12, "* ")
        call append(line(".")+13, "* =====================================================================================")
        call append(line(".")+14, "*/")
        call append(line(".")+15, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+16, "#include<iostream>")
        call append(line(".")+17, "using namespace std;")
        call append(line(".")+18, "")
    endif
    if &filetype == 'c'
        call append(line(".")+16, "#include<stdio.h>")
        call append(line(".")+17, "#include<stdlib.h>")
        call append(line(".")+18, "#include<stdint.h>")
        call append(line(".")+19, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+16, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+17, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+18, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+16,"public class ".expand("%:r"))
        call append(line(".")+17,"")
    endif
endfunc
"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"F3切换为内核编码风格
"""""""""""""""""""""""""""""""""""""""""""""""""""""
"备注：
"1. 内核源码有自己的编写规范，见Documentation/CodingStyle
"2. 有一个检测工具用于检测自己代码是否符合规范，scripts/checkpatch.pl，用法：scripts/checkpatch.pl -f test.c
"3. 内核中开源驱动没有严格的按照这个规范来写，但还是尽量保持统一吧
func! Kernel_style()
    set tabstop=8   "按下Tab时，Vim 显示的空格数
    set shiftwidth=8    "命令模式>>（增加一级缩进）、<<（取消一级缩进）或者==（取消全部缩进）时，每一级的字符数
    set softtabstop=8   "Tab转为多少个空格
    set textwidth=80    "设置行宽，内核代码规范要求行宽为80
    set colorcolumn=80  "行宽限制显示，超过80显示一个竖线
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"C，C++ 按F5编译运行
"""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -std=c++11 -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        "        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

"C,C++的调试
"map <F8> :call Rungdb()<CR>
"func! Rungdb()
"    exec "w"
"    exec "!g++ % -std=c++11 -g -o %<"
"    exec "!gdb ./%<"
"endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"代码格式优化化
"""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F6> :call FormartSrc()<CR><CR>
func! FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag list (ctags)
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"自动去行尾空格
"""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufWritePre * call TrimEndLines()
function! TrimEndLines()
    let save_cursor = getpos(".")
    "trim line end space
    :silent! %s/\s\+$//
    "trim  file end space line
    :silent! %s#\($\n\s*\)\+\%$##
    "silent normal! gg=G
    call setpos('.', save_cursor)
endfunction


"""""""""""""""""" Something else """""""""""""""""""""""
"到行首 0 or ^
"到行尾 end or $
"设置了smartindent 粘贴代码时会自动换行，导致粘贴时格式被破坏，可:set paste关闭，恢复使用:set nopaste
"
