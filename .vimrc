set encoding=utf-8 " required by YCM
let vim_markdown_preview_github=1

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

call plug#begin()

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Go languag support for vim
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries'}

Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

" Icon support
Plug 'ryanoasis/vim-devicons'

" Autocomplete
Plug 'ervandew/supertab'
Plug 'valloric/youcompleteme'

" Fuzzy finder PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Jsx synthax highlight for vim
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'chrisbra/csv.vim'

" Editor config
Plug 'editorconfig/editorconfig-vim'
Plug 'drewtempelmeyer/palenight.vim'

" Vim markdown
Plug 'JamshedVesuna/vim-markdown-preview'

" Snippets
Plug 'honza/vim-snippets'

" Code folding
Plug 'tmhedberg/SimpylFold'

" Colorschemes 
Plug 'flazz/vim-colorschemes'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kaicataldo/material.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Syntax helpers
Plug 'scrooloose/syntastic'
Plug 'Chiel92/vim-autoformat'
Plug 'othree/html5.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'jiangmiao/auto-pairs'
Plug 'lambdalisue/vim-django-support'
Plug 'alvan/vim-closetag'

" File tree
Plug  'scrooloose/nerdtree'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'zhaocai/GoldenView.Vim'
Plug 'benmills/vimux'

" Extras
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'majutsushi/tagbar'
Plug 'wincent/command-t'
Plug 'bling/vim-airline'

Plug 'easymotion/vim-easymotion'

" Initialize plugin system
call plug#end() 

" Airline powerline fonts
let g:airline_powerline_fonts=1
let NERDTreeIgnore = [ '__pycache__', '.vscode', '\.pyc$', '\.o$', '\.swp', '*\.swp', 'node_modules/' ]
let NERDTreeShowHidden=1
let NERDTreeWinSize=36

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.vue,*.php,*.phtml,*.js'
let g:SimpylFold_docstring_preview=1
let g:goldenview__enable_default_mapping = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" YCM compatibility with UltiSnips
let g:ycm_key_list_select_completion = [ '<C-n>', '<Down>' ] 
let g:ycm_key_list_previous_completion = [ '<C-p>', '<Up>' ]
let g:SuperTabDefaultCompletionType = '<C-n>'

" HTML indentation
" syntax enable
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "address,article,aside,audio,blockquote,canvas,dd,div,dl,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hgroup,hr,main,nav,noscript,ol,output,p,pre,section,table,tfoot,ul,video"

let g:pymode_python = 'python3'
let g:gruvbox_constrast_dark='hard'

" set foldmethod=indent
set foldlevel=99
set tags=./tags,tags;$HOME
set autochdir
set completeopt-=preview " disable preview window
set autochdir
set bs=2
set background=dark " required by gruvbox
set tabstop=4
set shiftwidth=4
set expandtab
set ruler
set hidden
set nowrap
" set autoindent
set softtabstop=4
set autoread
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set syntax=html

" let &colorcolumn="80"
set shortmess+=A " disable swap file warning

" hybrid line numbers
set number relativenumber

" split below and right
set splitbelow

" nerdtree toggle
map <C-n> :NERDTreeToggle<CR>

inoremap jj <ESC>:w<CR>

" autostart nerd-tree
" autocmd vimenter * NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:stdn_in") | NERDTree | endif

nnoremap <C-p> :<C-u>Files<CR>
nnoremap <C-i> :GoImports<CR>

" vimux binding
map <Leader>vp :VimuxPromptCommand<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <space> za 
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

augroup python
    autocmd!
    autocmd FileType python syn keyword pythonSelf self | highlight def link pythonSelf Special
augroup end

" Format automatically
augroup autoformat_settings
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    autocmd FileType python AutoFormatBuffer yapf
    " Alternative: autocmd FileType python AutoFormatBuffer autopep8
    autocmd FileType vue AutoFormatBuffer prettier
augroup END

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala,go let b:comment_leader = '// '
autocmd FileType sh,ruby,python      let b:comment_leader = '# '
autocmd FileType conf,fstab          let b:comment_leader = '# '
autocmd FileType tex                 let b:comment_leader = '% '
autocmd FileType mail                let b:comment_leader = '> '
autocmd FileType vim                 let b:comment_leader = '" '
noremap <silent> cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" auto indent on save
" augroup autoindent
"     au!
"     autocmd BufWritePre * :normal migg=G`i
" augroup End

au CursorHold * checktime
au FocusGained * :redraw!
au FocusGained * :q!

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" colorschemes 
" Dark: monokai-chris, gruvbox
" Light: ChocolatePapaya
colorscheme gruvbox

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
