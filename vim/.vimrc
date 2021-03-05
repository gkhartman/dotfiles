""""""""""""""""""""""""Global Settings""""""""""""""""""""""""""
" Set vi compatibility to off.
set nocompatible

" Enable Line Numbers.
set nu

" Enable syntax highlighting.
if !exists("g:syntax_on")
    syntax enable
endif

" Set tab key to insert 4 space characters.
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent

" Enable mouse support.
set mouse=a

" Column line limit ruler made up of a colored column of block chars.
set colorcolumn=100

" Filetype Auto Detect.
filetype on

" Enable termguicolor if available.
if(has("termguicolors"))
    set termguicolors
endif

" Set color schemes.
set background=dark     " Either dark or light background.

"""""""""""""""""""""""""GUI Settings""""""""""""""""""""""""""
" Settings normally found in .gvimrc file.
" If gui is running set gui related options.
if has('gui_running')

    " Set font type and size.
    set guifont=Monospace\ 12

    " Remove print button from gvim toolbar.
    aunmenu ToolBar.Print

    " Color scheme settings.
    colorscheme elflord

endif

""""""""""""""""""""Neovim Only Settings"""""""""""""""""""
if !has('nvim')
    set ttymouse=xterm2
endif

""""""""""""""""""""Plugin Related Settings""""""""""""""""""""
" Enable formatting for vim plugin filetype
filetype plugin on
filetype plugin indent on

" Vim-Plug Plugin installer resources
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/syntastic'               " Syntax checker
Plug 'scrooloose/nerdtree'                " Dir tree explorer
Plug 'octol/vim-cpp-enhanced-highlight'   " C++11/14 syntax highlighting support
Plug 'juneedahamed/vc.vim'                " Repo tools
Plug 'vim-scripts/Conque-GDB'             " Conque gdb debugger integration
Plug 'tfnico/vim-gradle'                  " Gradle integration
Plug 'othree/xml.vim'                     " Xml completion
Plug 'SidOfc/mkdx'                        " Markdown Tools and Support
Plug 'ervandew/supertab'                  " Jetbrains-like smart tab completion
Plug 'rakr/vim-one'                       " One-dark vim color theme
Plug 'vim-airline/vim-airline'            " Powerline-like light status line
Plug 'vim-airline/vim-airline-themes'     " Status line themes
Plug 'tomasr/molokai'                     " Molokai color theme
Plug 'stephpy/vim-yaml'                   " YAML Syntax Support

" Python mode plugin to enable python linters and PEP format checking.
Plug 'python-mode/python-mode', { 'branch': 'develop' }

" Language server client for neovim.
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }

" Optional addons that are used by LanguageClient-neovim.
" Plug 'junegunn/fzf'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

" Enable python interpreter.
let g:pymode_python = 'python3'

" Get pynvim python interpreter from virtualenv (machine specific).
let g:python3_host_prog = '/home/ghartman/.virtualenvs/alert_review_console/bin/python3'

" Language client config.
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['pyls'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" Syntastic syntax check plug-in recommended settings.
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_mode="passive"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_check_on_w = 0
"let g:syntastic_cpp_compiler = 'gcc'
"let g:syntastic_check_c_compiler_options = '-std=c++11'

" Opening files via NERDTree creates a new tab by default.
let NERDTreeMapOpenInTab = '<ENTER>'

" Map control F12 to generate ctags for c++ omnicomplete.
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Syntax highlight settings.
let c_no_curly_error = 1   " C++11/14 
let python_highlight_all = 1 " Python
