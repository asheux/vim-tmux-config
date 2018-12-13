set nocompatible  " be iMproved, required
set encoding=utf-8 " required by YCM
filetype off      " required
let vim_markdown_preview_github=1
call plug#begin('~/.vim/plugged')

" ======== plugin manager
Plug  'VundleVim/Vundle.vim'

" ========== autocomplete
Plug 'ervandew/supertab'
Plug 'valloric/youcompleteme', { 'do': './install.py' }
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" YCM compatibility with UltiSnips
let g:ycm_key_list_select_completion = [ '<C-n>', '<Down>' ] 
let g:ycm_key_list_previous_completion = [ '<C-p>', '<Up>' ]
let g:SuperTabDefaultCompletionType = '<C-n>'
set completeopt-=preview " disable preview window
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" auto indent on save
augroup autoindent
    au!
    autocmd BufWritePre * :normal migg=G`i
augroup End

" Jsx synthax highlight for vim

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" ========= Editor config
Plug 'editorconfig/editorconfig-vim'
Plug 'drewtempelmeyer/palenight.vim'
" ========= vim markdown
Plug 'JamshedVesuna/vim-markdown-preview'
" ========= snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ============= code folding
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1
set foldmethod=indent
set foldlevel=99
nnoremap <space> za 

" ========== colorschemes 
Plug 'flazz/vim-colorschemes'
inoremap jj <ESC>:w<CR>

" =========== git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kaicataldo/material.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'

" ========= syntax helpers
Plug 'scrooloose/syntastic'
Plug 'Chiel92/vim-autoformat'
Plug 'othree/html5.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'jiangmiao/auto-pairs'
Plug 'lambdalisue/vim-django-support'
Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.vue,*.php,*.phtml,*.js'

" ========= file tree
Plug  'scrooloose/nerdtree'
let NERDTreeIgnore = [ '__pycache__',  '\.pyc$', '\.o$', '\.swp', '*\.swp', 'node_modules/' ]
let NERDTreeShowHidden=1

" ========= navigation
Plug 'christoomey/vim-tmux-navigator'
" autostart nerd-tree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:stdn_in") | NERDTree | endif
" nerdtree toggle
map <C-n> :NERDTreeToggle<CR>
Plug 'zhaocai/GoldenView.Vim'
let g:goldenview__enable_default_mapping = 0
Plug 'benmills/vimux'
" vimux binding
map <Leader>vp :VimuxPromptCommand<CR>
nmap <F8> :TagbarToggle<CR>

" ======= fuzzy find
Plug 'ctrlpvim/ctrlp.vim'

" ======= extras
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'majutsushi/tagbar'
Plug 'wincent/command-t'
Plug 'bling/vim-airline'
" airline powerline fonts
let g:airline_powerline_fonts=1

Plug 'easymotion/vim-easymotion'

call plug#end()            " required
filetype plugin indent on    " required

" ============= extra settings
set autochdir
syntax on
" Enable backspace on vim
set bs=2
" tabs to 4 spaces
" set smartindent
set background=dark " required by gruvbox
set tabstop=4
set shiftwidth=4
" set mouse=a
set expandtab
set ruler
set hidden
set nowrap											" Do not wrap long lines
set autoindent									" Indent at the same level of the previous line
set softtabstop=4								" Let backspace delete indent
set autoread
au CursorHold * checktime
au FocusGained * :redraw!
au FocusGained * :q!
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set syntax=html
" let &colorcolumn="80"
:set guioptions-=m " remove menu bar
:set guioptions-=T " remove toolbar
:set guioptions-=r " remove right-hand scroll bar
:set guioptions-=L " remove left-hand scroll bar
":set lines=999 columns=999
set shortmess+=A " disable swap file warning

" hybrid line numbers
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
" colorschemes 
" Dark: monokai-chris, gruvbox
" Light: ChocolatePapaya
" colorscheme gruvbox
" let g:gruvbox_constrast_dark='hard'

" split below and right feels more natural
set splitbelow

"
" HTML indentation
"
" colorscheme material
colorscheme palenight

" syntax enable
" colorscheme monokai
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "address,article,aside,audio,blockquote,canvas,dd,div,dl,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hgroup,hr,main,nav,noscript,ol,output,p,pre,section,table,tfoot,ul,video"

"if (has("nvim"))
"    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"if (has("termguicolors"))
"    set termguicolors
"endif

if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif

let g:lightline = { 'colorscheme': 'palenight'}
" let g:material_theme_style = 'default'
