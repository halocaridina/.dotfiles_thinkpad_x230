set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

Plugin 'gmarik/Vundle.vim'

Plugin 'xolox/vim-colorscheme-switcher'

Plugin 'godlygeek/csapprox'

Plugin 'xolox/vim-misc'

Plugin 'ervandew/supertab'

Plugin 'flazz/vim-colorschemes'

Plugin 'scrooloose/nerdtree'

Plugin 'Lokaltog/vim-easymotion'

Plugin 'SearchComplete'

Plugin 'PotatoesMaster/i3-vim-syntax'

Plugin 'vim-airline/vim-airline'

Plugin 'smancill/conky-syntax.vim'

Plugin 'vim-airline/vim-airline-themes'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let mapleader = ","
set backupdir=~/.vim/backup

set encoding=UTF-8

set mouse=r
set mousehide

set shortmess+=filmnrxoOtT
set history=1000

set backup
if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
    set undodir=~/.vim/undo_files
endif

syntax on
set background=dark
set t_Co=256
colorscheme ir_black

let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
let g:CSApprox_hook_post = ['hi Normal ctermbg=NONE', 'hi NonText ctermbg=NONE' ]

set tabpagemax=15
set noshowmode

set cursorline

highlight clear SignColumn
highlight clear LineNr

if has('cmdline_info')
    set ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd
endif

if has('statusline')
    set laststatus=2
    set statusline=%<%f\
    set statusline+=%w%h%m%r
    set statusline+=\ [%{&ff}/%Y]
    set statusline+=\ [%{getcwd()}]
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%
endif

" Set the status bar using the airline plugin
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

set backspace=indent,eol,start
set linespace=0
set number
set showmatch
set incsearch
set hlsearch
set winminheight=0
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]
set scrolljump=5
set scrolloff=3
set foldenable
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

set nowrap
set autoindent
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4
set nojoinspaces
set splitright
set splitbelow
set pastetoggle=<F3>
set go+=a

if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif

nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap j gj
nnoremap k gk

 " NerdTree {
if isdirectory(expand("~/.vim/bundle/nerdtree"))
nmap <silent> <special> <F2> :NERDTreeToggle<RETURN>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
endif
" }
