" =============
" BasicSetting
" =============
  

" set everyline with number
set number
" Show line number on the current line and relative numbers on all other lines.
set relativenumber
" will not carrage return when line within symbol below
set iskeyword+=_,$,@,%,#,-,/

" shift and tab setting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

" Enable mouse support
set mouse=a
" Disable noerrorbells
set noerrorbells visualbell t_vb=
" Highlight the line currently under cursor.
set cursorline
" enable hightlight searching
set hlsearch
" See ":help leader" for more information.
let mapleader = ","

set encoding=utf-8
set hidden
set nobackup
set nowritebackup
" set cmdheight=2

" Proper Search
set incsearch
set ignorecase
set smartcase
set gdefault

" Status Bar
" default the statusline to green when entering Vim
" hi statusline guifg=Blue ctermfg=8 guifg=Blue ctermbg=15
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=Blue ctermfg=8 guifg=White ctermbg=15


set laststatus=2
" set statusline=
" set statusline+=%#PmenuSel#
" set statusline+=%{StatuslineGit()}
" set statusline+=%#LineNr#
" set statusline+=\ %f
" set statusline+=%m\
" set statusline+=%=
" set statusline+=%#CursorColumn#
" set statusline+=\ %y                    " Filetype
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\[%{&fileformat}\]
" set statusline+=\ %p%%                  " Percentage
" set statusline+=\ %l:%c                 " Line number: Column relative
" set statusline+=\


function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
"if has("nvim-0.5.0") || has("patch-8.1.1564")
"  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes:1
"endif
set signcolumn=yes


" Open file remember history status
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif
endif




" =============
" KeyBinding
" =============


" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>
" nmap R <Nop>


" set 'jj' into normal mod
inoremap jj <esc>

nnoremap <C-[> <esc>
vnoremap <C-[> <esc>
snoremap <C-[> <esc>
xnoremap <C-[> <esc>
onoremap <C-[> <esc>

" ========================Window Managemnt=========================

" Navigate window
nnoremap <silent> <space>h <C-w>h
nnoremap <silent> <space>l <C-w>l
nnoremap <silent> <space>j <C-w>j
nnoremap <silent> <space>k <C-w>k

" Resize split screen
nmap <leader>j :res +5<CR>
nmap <leader>k :res -5<CR>
nmap <leader>l :vertical res-5<CR>
nmap <leader>h :vertical res+5<CR>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap <leader>u :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap <leader>o :set splitbelow<CR>:split<CR>
noremap <leader>p :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap <leader>i :set splitright<CR>:vsplit<CR>


" ========================Tab Managemnt=========================

" Open a NewTab with tu
noremap tu :tabnew<CR>
noremap tU :tab split<CR>
" Move around tabs with tn and tp
noremap tn :+tabnext<CR>
noremap tp :-tabnext<CR>
" Move the tabs with tmn and tmp
noremap tmn :+tabmove<CR>
noremap tmp :-tabmove<CR>
" Close current tab
noremap tc <C-w>c


" ========================Cursor support=========================


noremap <silent> E 5j
noremap <silent> W 5k
" B/J keys for 5 times b/w (faster navigation)
noremap <silent> B 5b
noremap <silent> J 5w
" <space>h : go to the start of the line
noremap <silent><nowait> <C-h> ^
" <space>l : go to the end of the line
noremap <silent><nowait> <C-l> $


" =============
" PluginManager
" =============


" use Vundle to mangae 
"if empty(glob('~/.vim/bundle/Vundle.vim'))
"	silent execute 'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
"	an VimEnter * PluginInstall --sync | source $MYVIMRC
"endif 

" use vim-plug to manage
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" =============
" PluginBegin
" =============


set nocompatible              " be iMproved, required
filetype off                  " required


call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" use git in vim
Plug 'tpope/vim-fugitive'

" git diff in vim
Plug 'airblade/vim-gitgutter'

" file explore
Plug 'preservim/nerdtree'

" highlight
Plug 'jackguo380/vim-lsp-cxx-highlight'

" plugin from http://vim-scripts.org/vim/scripts.html
Plug 'vim-scripts/L9'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}

"auto complete pairs
Plug 'jiangmiao/auto-pairs'

"Plug 'Valloric/Youcompleteme'

" lsp and completion, build from source
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }

" statusline profile
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" vim time statistics
Plug 'wakatime/vim-wakatime'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


" ================
" Plugins Settings
" ================


" ======YouComleteSet=====


" set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" "回车即选中当前项
" "上下左右键的行为 会显示其他信息
" inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
" inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" youcompleteme 默认tab s-tab 和自动补全冲突
" let g:ycm_key_list_select_completion=['<c-n>']
" let g:ycm_key_list_select_completion = ['<Tab>', '<Down>']
" let g:ycm_key_list_previous_completion=['<c-p>']
"let g:ycm_key_list_previous_completion = ['<S-Tab>', '<Up>']
"let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
" close completion menu
"let g:ycm_key_list_stop_completion = ['<C-y>']
"let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
"let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
"let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项,每次都重新生成匹配项
"let g:ycm_seed_identifiers_with_syntax=1 " 语法关键字补全
" force recomile with syntastic
"inoremap <F5> :YcmForceCompileAndDiagnostics<CR> 
" nnoremap <leader>lo :lopen<CR> "open locationlist
" nnoremap <leader>lc :lclose<CR> "close locationlist
"inoremap <leader><leader> <C-x><C-o>
" 在注释输入中也能补全
"let g:ycm_complete_in_comments = 1
" 在字符串输入中也能补全
"let g:ycm_complete_in_strings = 1
" 注释和字符串中的文字也会被收入补全
"let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 跳转到定义处
"inoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> 


" ======NERDTree======


" show hidden file
let NERDTreeShowHidden=1
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


" ====== vim-lsp-cxx-highlight======


" hi default link LspCxxHlSymFunction cxxFunction
" hi default link LspCxxHlSymFunctionParameter cxxParameter
" hi default link LspCxxHlSymFileVariableStatic cxxFileVariableStatic
" hi default link LspCxxHlSymStruct cxxStruct
" hi default link LspCxxHlSymStructField cxxStructField
" hi default link LspCxxHlSymFileTypeAlias cxxTypeAlias
" hi default link LspCxxHlSymClassField cxxStructField
" hi default link LspCxxHlSymEnum cxxEnum
" hi default link LspCxxHlSymVariableExtern cxxFileVariableStatic
" hi default link LspCxxHlSymVariable cxxVariable
" hi default link LspCxxHlSymMacro cxxMacro
" hi default link LspCxxHlSymEnumMember cxxEnumMember
" hi default link LspCxxHlSymParameter cxxParameter
" hi default link LspCxxHlSymParameter cxxTypeAlias


" ======Coc.nvimSet=======


" Coc extensions
let g:coc_global_extensions = [
\ 'coc-vimlsp',
\ 'coc-sh',
\ 'coc-cmake',
\ 'coc-pyright',
\ 'coc-json',
\ 'coc-prettier',
\ 'coc-marketplace',
\ 'coc-highlight'
\]


" Add this to avoid version message
 let g:coc_disable_startup_warning = 1


" Trigger negiative
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A


function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline(',')[col-1] =~# '\s'
endfunction


" Trigger completion
if has('nvim')
	inoremap <silent><expr> <c-o> coc#refersh()
else 
	inoremap <silent><expr> <c-@> coc#refersh()
endif


" Use <CR> auto select the first completion item
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
		\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"  


" Diagnostic info and navigation
nnoremap <silent><nowait> <leader>d :CocList diagnostic<CR>
nmap <silent> <leader>- <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>= <Plug>(coc-diagnostic-next)
nmap <leader>qf <Plug>(coc-fix-current)


" Goto code navigation.
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function s:show_documentation()
   if CocAction('hasProvider', 'hover')
	   call CocActionAsync('doHover')
   else
	   call feedkeys('K', 'in')
	endif
endfunction


" scroll float window/popips
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
	inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ?  "\<c-r>=coc#float#scroll(1)\<cr>" : "\<right>"
	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ?  "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1)
	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0)
endif


" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')


" Format selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)


" Rename 
nmap <leader>rn <Plug>(coc-rename)


" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" Setup Prettier command 
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand','editor.action.organizeImport')"


" ==========================Mappings for CoCList===========================
" Open CocList
nnoremap <silent> <space>g :<C-u>CocList --normal gstatus<CR>

" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>n  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>p  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>r  :<C-u>CocListResume<CR>


" a function to generate compile command to .vscode
function! s:generate_compile_commands()
	if empty(glob('CMakeLists.txt'))
		echo "Can't find CMakeLists.txt"
		return 
	endif
	execute '!cmake -DCMAKE_BUILD_TYPE=debug
				\ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_commands()


" ======vim-airline=======


let g:airline_section_z="%p%%"
let g:airline_theme='angr'

let g:airline#extensions#coc#enabled = 0
let airline#extensions#coc#error_symbol = 'Error:'
let airline#extensions#coc#warning_symbol = 'Warning:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'


" ====================GitGutter====================

" let g:gitgutter_signs = 1
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
nnoremap <leader>gf :GitGutterFold<CR>
nnoremap <leader>gd :GitGutterPreviewHunk<CR>
nnoremap <leader>g- :GitGutterPrevHunk<CR>
nnoremap <leader>g= :GitGutterNextHunk<CR>


" ====================ultisnips=====================

let g:UltiSnipsExpandTrigger="<C-tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"


" ====================vim-fugitive=====================
 
" To learn more see:
" :h fugitive
" :h :Git
" :h :Gw
" :h :Git commit
" :h :windo
" :h :x
" to add file: 
"     in command line :Git
"     then use '-' to add or remove file
"     Start committing via cc whilst in the status window
"
" Or use a more easy way:
" :windo Gw
" :Git commit



