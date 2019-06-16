" 基本配置=============================================================
set nocompatible              " be iMproved, required
filetype off                  " required

set encoding=utf-8

set tabstop=4                 " 设置制表符长度
set softtabstop=4             " 设置软制表符
set shiftwidth=4              " 缩进长度

set number                    " 打开行号

syntax enable				  "开启语法高亮功能
syntax on
 
set t_Co=256				  "指定配色方案为256色

" 需要配合vimrc_example.vim注释一些代码
set nobackup				  "表示不需要备份文件
set noswapfile				  "表示不创建临时交换文件
set nowritebackup			  "表示编辑的时候不需要备份文件
set noundofile				  "表示不创建撤销文件

" 设置代码折叠为手动
set foldmethod=manual
"打开文件是默认不折叠代码
set foldlevelstart=99
" 基本配置=============================================================

source $VIMRUNTIME/vimrc_example.vim

" vim-plug: Vim plugin manager
call plug#begin('$VIMRUNTIME/../plugged')
" 自动补全 此插件安装的时候需要手动编译
Plug 'Valloric/YouCompleteMe'   ",{'on':[]}			                 	
" augroup load_ycm
"     autocmd!
"     autocmd InsertEnter * call plug#load('YouCompleteMe') | autocmd! load_cmd
" augroup END
Plug 'scrooloose/nerdtree'                    							" 目录树
Plug 'vim-airline/vim-airline'                							" 状态栏
"Plug 'majutsushi/tagbar',{'on':'TagbarToggle'}						    " 标签插件 非C类禁用 tagbar 不然打开文件卡顿
Plug 'kien/ctrlp.vim'					    							" 文件搜索
Plug 'vim-airline/vim-airline-themes'									" 状态栏主题
Plug 'godlygeek/tabular'												" -------------------
Plug 'plasticboy/vim-markdown'											" Vim markdown语法插件
Plug 'flazz/vim-colorschemes'               							" 代码高亮, 主题
Plug 'hzchirs/vim-material'												" material主题
Plug 'stephpy/vim-php-cs-fixer'											" php格式化
Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }						" 搜索插件
Plug 'vim-scripts/gtags.vim'											" gtags
Plug 'vim-scripts/cscope.vim'											" cscope
Plug 'whatot/gtags-cscope.vim'											
Plug 'ludovicchabant/vim-gutentags'										" gtags辅助
call plug#end()

" 添加 http://github.com/tpope/vim-unimpaired 插件 用来补充一些映射

" scheme 配置=========================================================
" colorscheme molokai
colorscheme desert
" set background=light
"colorscheme vim-material
" colorscheme wombat
" scheme 配置=========================================================

" nerdtree 配置========================================================
nnoremap <silent> <F5> :NERDTree<CR>            " F5 开启
" nerdtree 配置========================================================

" YouCompleteMe 配置===================================================
let g:ycm_global_ycm_extra_conf = '$VIMRUNTIME/../.ycm_extra_conf.py' 					"此处是全局配置文件路径
let g:ycm_confirm_extra_conf = 0 													"关闭每次导入配置文件前的询问
"let g:syntastic_always_populate_loc_list = 1 										"方便使用syntastic进行语法检查
let g:ycm_seed_identifiers_with_syntax=1 											"开启语法关键字补全
let g:ycm_add_preview_to_completeopt=0												"关闭补全预览
let g:ycm_semantic_triggers =  {													
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }																		"语义补全
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" "修改提示框颜色
highlight Pmenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PmenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black					
" 错误标记
let g:ycm_error_symbol = '✗'  "set error or warning signs

" warning标记
let g:ycm_warning_symbol = '⚠'

"highlight YcmErrorSign       标记颜色
"highlight YcmWarningSign ctermbg=none
"highlight YcmErrorSection      代码中出错字段颜色
highlight YcmWarningSection ctermbg=none
"highlight YcmErrorLine        出错行颜色
"highlight YcmWarningLine

" 跳转快捷键
nnoremap <c-k> :YcmCompleter GoToDeclaration<CR>|
nnoremap <c-h> :YcmCompleter GoToDefinition<CR>| 
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|
" YouCompleteMe 配置===================================================

source $VIMRUNTIME/cscope_maps.vim

" gutentags 配置========================================================
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0
" gutentags 配置========================================================

" Gtags 配置========================================================
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = 'D:/Program Files (x86)/Vim/extends/gtags/share/gtags/gtags.conf'
" cscope
set cscopetag                  " 使用 cscope 作为 tags 命令
set cscopeprg=gtags-cscope   " 使用 gtags-cscope 代替 cscope

" gtags
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
" Gtags 配置========================================================


" LeaderF 配置========================================================
noremap <F2> :LeaderfFunction!<cr>           
let g:Lf_Gtagsconf = 'D:/Program Files (x86)/Vim/extends/gtags/share/gtags/gtags.conf'
" LeaderF 配置========================================================


" airline theme 配置===================================================
" let g:airline_theme='bubblegum'							" airline 主题
let g:airline#extensions#tabline#enabled = 1			" smart tab line 开启
" let g:airline_theme='material'
" airline theme 配置===================================================


" ====================================================================
" 设置字体
if has("gui_running")
	if has("gui_gtk2")
		set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
		set guifont=Menlo\ Regular:h14
	elseif has("gui_win32")
		set guifont=Consolas:h12:cANSI
		"set guifont=monaco:h11:cANSI
    endif
endif
" ====================================================================

" Vim-php-cs-fixer 配置==================================================
" If php-cs-fixer is in $PATH, you don't need to define line below
let g:php_cs_fixer_path = "C:/wamp64/bin/php/php7.2.4/php-cs-fixer-v2.phar" " define the path to the php-cs-fixer.phar

" If you use php-cs-fixer version 1.x
" let g:php_cs_fixer_level = "symfony"                   " options: --level (default:symfony)
" let g:php_cs_fixer_config = "default"                  " options: --config
" If you want to define specific fixers:
"let g:php_cs_fixer_fixers_list = "linefeed,short_tag" " options: --fixers
"let g:php_cs_fixer_config_file = '.php_cs'            " options: --config-file
" End of php-cs-fixer version 1 config params

" If you use php-cs-fixer version 2.x
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
"let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
"let g:php_cs_fixer_config_file = '.php_cs' " options: --config
" End of php-cs-fixer version 2 config params

let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>
" =======================================================================

" 窗口透明度 配置========================================================
if has('gui_running') && has('libcall')
	let g:MyVimLib = $VIMRUNTIME.'/gvimfullscreen.dll'
	function ToggleFullScreen()
		call libcallnr(g:MyVimLib, "ToggleFullScreen", 0)
	endfunction
    
	"Alt+Enter
	map <A-Enter> <Esc>:call ToggleFullScreen()<CR>

	let g:VimAlpha = 240
	function! SetAlpha(alpha)
		let g:VimAlpha = g:VimAlpha + a:alpha
		if g:VimAlpha < 180
			let g:VimAlpha = 180
		endif
		if g:VimAlpha > 255
			let g:VimAlpha = 255
		endif
		call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
	endfunction
    
	"Shift+Y
	nmap <s-y> <Esc>:call SetAlpha(3)<CR>
	"Shift+T
	nmap <s-t> <Esc>:call SetAlpha(-3)<CR>

	function! SwitchVimAlpha()
		if g:VimAlpha != 180
			let g:VimAlpha = 180
		else
			let g:VimAlpha = 255
		endif
		call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
	endfunction
	" F8
	map <F8> :call SwitchVimAlpha()<CR>

	let g:VimTopMost = 0
	function! SwitchVimTopMostMode()
		if g:VimTopMost == 0
			let g:VimTopMost = 1
		else
			let g:VimTopMost = 0
		endif
		call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
	endfunction
    
	"Shift+R
	nmap <s-r> <Esc>:call SwitchVimTopMostMode()<CR>
endif

" 窗口透明度 配置========================================================


"
"
"You Complete Me 编译
"需要安装vim对应版本的python，查看方式为： :version
"安装 VS2017 或者 VS2015
"下载YCM插件源码后，如下命令编译插件：
"python install.py --clang-completer --msvc 15


