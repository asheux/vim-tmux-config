" Plugin management with vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! SetupLayout()
    if argc() != 0
        return
    endif

    NERDTree
    wincmd l

    split
    execute 'resize' . (winheight(0) - g:terminal_height)

    wincmd j
    vsplit

    wincmd h
    enew
    call term_start(&shell, { 'curwin': v:true })
    startinsert

    wincmd l
    enew
    call term_start('htop', {'curwin': v:true})
    startinsert

    wincmd k
    wincmd h
endfunction

" Vim mergetool customization
" (m) - for working tree version of MERGED file
" (r) - for 'remote' revision
" common ancestor of two branches, i.e. git merge-base branchX branchY
function s:on_mergetool_set_layout(split)
    if a:split["layout"] ==# 'mr,b' && a:split["split"] ==# 'b'
        set nodiff
        set syntax=on
        resize 15
    endif
endfunction

packloadall
" Initialize plugin system
call plug#begin()

" Themes
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ghifarit53/tokyonight-vim'

" Fuzzy finder PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Debugger
Plug 'puremourning/vimspector'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Code formatting and linting
Plug 'prettier/vim-prettier', {
            \ 'do': 'yarn install --frozen-lockfile --production',
            \ 'for': ['javascript', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'jsx', 'tsx'] }
Plug 'psf/black', { 'branch': 'stable' }
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'Chiel92/vim-autoformat'

" Vim mergetool
Plug 'samoshkin/vim-mergetool'

" Syntax and anguage support for vim
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries'}
Plug 'othree/html5.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'chrisbra/csv.vim'
Plug 'voldikss/vim-mma'
Plug 'plasticboy/vim-markdown'

" Autocomplete and snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'

" Navigation and productivity
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Editor config
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editor config
Plug 'editorconfig/editorconfig-vim'

Plug 'kaicataldo/material.vim'

" Extras
Plug 'majutsushi/tagbar'

call plug#end()

" General settings 
set number relativenumber
set autoindent smartindent cindent
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set hidden
set nowrap
set incsearch hlsearch ignorecase smartcase
set showmatch " Show matching brackets/parenthesis
set autoread
set backspace=indent,eol,start
set scrolloff=5
set sidescrolloff=10
set clipboard= " unnamedplus " System clipboard integration
set mouse=a " Enable mouse support
set updatetime=300 " Faster updates for plugins like GitGutter
set foldlevel=99
set tags=./tags,tags;$HOME
set autochdir
set completeopt-=preview " disable preview window
set background=dark " required by gruvbox
set bs=2
set ruler
set syntax=html
set shortmess+=A " disable swap file warning
set splitbelow
set splitright
set syntax=wl
if (has("termguicolors"))
    set termguicolors
endif

set directory=~/.vim/swap//
silent !mkdir -p ~/.vim/swap

" Dark: tokyonight, gruvbox, badwolf, dracula
colorscheme gruvbox

let g:tokyonight_style = "moon"  " or 'moon' or 'night' or 'day'
"
" Leader key
let mapleader = "\<Space>"

" See `man fzf-tmux` for available options
if exists('$TMUX')
    let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" Set up global configuration dictionary
let vim_markdown_preview_github=1

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

" Airline configuration
let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'

" COC CONFIGURATION 
set encoding=utf-8
set nobackup
set nowritebackup
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>sf  <Plug>(coc-format-selected)
nmap <leader>sf  <Plug>(coc-format-selected)

" augroup mygroup
"     autocmd!
"     " Setup formatexpr specified filetype(s)
"     autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" augroup end

let g:mergetool_layout = 'mr,b'
let g:mergetool_prefer_revision = 'local' " possible values: 'local' (default), 'remote', 'base'
let g:MergetoolSetLayoutCallback = function('s:on_mergetool_set_layout')

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 50
let g:NERDTreeMapMenu = 'm'
let NERDTreeIgnore = ['\.sw[a-z]$', '\~$', '\.bak$', 'venv', '\.sv[a-z]$', '__pycache__', '.pytest_cache', '.ruff_cache', '.idea']

" Terminal configuration for htop and shell
let g:terminal_height = 15

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.vue,*.php,*.phtml,*.js'
let g:SimpylFold_docstring_preview=1
let g:goldenview__enable_default_mapping = 0

" HTML indentation
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "address,article,aside,audio,blockquote,canvas,dd,div,dl,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hgroup,hr,main,nav,noscript,ol,output,p,pre,section,table,tfoot,ul,video"

let g:pymode_python = 'python3'

" Disable unnecessary autoformat features
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" Disable vim-prettier autoformatting on save
let g:prettier#autoformat = 0
let g:prettier#autoformat_require_pragma = 0
let g:prettier#quickfix_enabled = 0

command! -nargs=? Fold :call CocAction('fold', <f-args>)

nnoremap <leader>t :call NERDTreeAddNode()<CR>
nnoremap <leader>d :call NERDTreeDeleteNode()<CR>

augroup StartupLayout
    autocmd!
    autocmd VimEnter * doautocmd User VimStartupDone
    autocmd User VimStartupDone call SetupLayout()
augroup END

" Format automatically
" augroup autoformat_settings
"     autocmd FileType bzl AutoFormatBuffer buildifier
"     autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
"     autocmd FileType dart AutoFormatBuffer dartfmt
"     autocmd FileType go AutoFormatBuffer gofmt
"     autocmd FileType gn AutoFormatBuffer gn
"     autocmd FileType html,css,sass,scss,less AutoFormatBuffer js-beautify
"     autocmd FileType javascript,jsx,typescript,typescriptreact,tsx,markdown,graphql,yaml,html,css,sass,scss,less AutoFormatBuffer prettier 
"     autocmd FileType python AutoFormatBuffer black
"     autocmd FileType vue AutoFormatBuffer prettier
" augroup END

" Clear autoformat group
augroup autoformat_settings
    autocmd!
augroup END

" Manual formatting command
command! FormatBuffer call s:FormatBuffer()

function! s:FormatBuffer()
    let l:save = winsaveview()
    if &filetype ==# 'c' || &filetype ==# 'cpp' || &filetype ==# 'proto'
        execute 'AutoFormatBuffer clang-format'
    elseif &filetype ==# 'dart'
        execute 'AutoFormatBuffer dartfmt'
    elseif &filetype ==# 'go'
        execute 'AutoFormatBuffer gofmt'
    elseif &filetype ==# 'html' || &filetype ==# 'css' || &filetype ==# 'sass' || &filetype ==# 'scss' || &filetype ==# 'less'
        execute 'AutoFormatBuffer js-beautify'
    elseif &filetype ==# 'javascript' || &filetype ==# 'jsx' || &filetype ==# 'typescript' || &filetype ==# 'typescriptreact' || &filetype ==# 'tsx' || &filetype ==# 'markdown' || &filetype ==# 'graphql' || &filetype ==# 'yaml' || &filetype ==# 'vue'
        execute 'AutoFormatBuffer prettier'
    elseif &filetype ==# 'python'
        execute 'AutoFormatBuffer black'
    else
        echo "No formatter defined for this filetype"
    endif
endfunction

" Map to a key
nnoremap <leader>f :FormatBuffer<CR>

" Commenting blocks of code.
augroup comment_file
    autocmd FileType c,cpp,javascript,typescriptreact,typescript,java,scala,go let b:comment_leader = '// '
    autocmd FileType sh,ruby,python      let b:comment_leader = '# '
    autocmd FileType conf,fstab          let b:comment_leader = '# '
    autocmd FileType tex                 let b:comment_leader = '% '
    autocmd FileType mail                let b:comment_leader = '> '
    autocmd FileType vim                 let b:comment_leader = '" '
augroup END

augroup format_config_file
    " Auto format this file
    autocmd BufWritePre .vimrc let save_cursor = getpos(".") | execute "normal! gg=G" | call setpos('.', save_cursor)
    " Auto-format .zshrc file on save
    autocmd BufWritePre .zshrc execute "normal! gg=G" | let $MYZSHRC = expand('%:p')
    autocmd BufWritePre ./.zshrc :%!shfmt -w
augroup END

augroup python
    autocmd!
    autocmd FileType python syn keyword pythonSelf self | highlight def link pythonSelf Special
augroup END

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

map <F10> :set paste<CR>
map <F11> :set nopaste<CR>

" Key mappings
inoremap jj <ESC>:w<CR>
nnoremap <C-p> :<C-u>Files<CR>
nnoremap <C-,> :<C-u>Buffers<CR>
nnoremap <C-w> :<C-u>Windows<CR>
nnoremap <C-s> :<C-u>Marks<CR>
nnoremap <C-m> :Git blame<CR>
nmap <leader>mt <plug>(MergetoolToggle)
map <Leader>vp :VimuxPromptCommand<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <space> za 
noremap <silent> cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

au CursorHold * checktime
au FocusGained * :redraw!

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>,
            \ fzf#vim#with_preview({'dir': systemlist(
            \ 'bash ~/Projects/Configs/vim-tmux-config/cronjobs/base_dir.sh')[0]}), <bang>0)

" Debugpy Key mappings
nmap <leader>p :call vimspector#Launch()<CR>
nmap <leader>rip :call vimspector#Reset()<CR>
nmap <leader>b :call vimspector#ToggleBreakpoint()<CR>
nmap <leader>so :call vimspector#StepOver()<CR>
nmap <leader>si :call vimspector#StepInto()<CR>
nmap <leader>st :call vimspector#StepOut()<CR>

packadd! vimspector
let g:vimspector_base_dir = expand('$HOME/.vimspector/configurations')
