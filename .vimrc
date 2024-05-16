" Set up global configuration dictionary
let vim_markdown_preview_github=1

" Plugin management with vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialize plugin system
call plug#begin()

" Themes
Plug 'morhetz/gruvbox'

" Vim mergetool
Plug 'samoshkin/vim-mergetool'

" Go language support for vim
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries'}
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'

" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

" Autocomplete
Plug 'ervandew/supertab'

" Fuzzy finder PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Jsx synthax highlight for vim
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'chrisbra/csv.vim'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install'  }

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Vim markdown
Plug 'JamshedVesuna/vim-markdown-preview'

" Snippets
Plug 'honza/vim-snippets'

" Code folding
Plug 'tmhedberg/SimpylFold'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kaicataldo/material.vim'

" Syntax helpers
Plug 'Chiel92/vim-autoformat'
Plug 'othree/html5.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'zhaocai/GoldenView.Vim'
Plug 'benmills/vimux'

" Extras
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'majutsushi/tagbar'
Plug 'wincent/command-t'
Plug 'easymotion/vim-easymotion'

" Black formatter installation 
Plug 'psf/black', { 'branch': 'stable' }

call plug#end()

" Auto format this file
autocmd BufWritePre .vimrc let save_cursor = getpos(".") | execute "normal! gg=G" | call setpos('.', save_cursor)

" Auto-format .zshrc file on save
autocmd BufWritePre .zshrc execute "normal! gg=G" | let $MYZSHRC = expand('%:p')
autocmd BufWritePre ./.zshrc :%!shfmt -w

" Initialize configuration dictionary
let g:fzf_vim = {}

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
            \ call fzf#vim#files(<q-args>,
            \ fzf#vim#with_preview({'dir': systemlist(
            \ 'bash ~/Projects/Configs/vim-tmux-config/cronjobs/base_dir.sh')[0]}), <bang>0)

command! -bang -complete=dir -nargs=? LS
            \ call fzf#run(fzf#wrap('ls', {'source': 'ls', 'dir': <q-args>}, <bang>0))

" Terminal colors for seoul256 color scheme
if has('nvim')
    let g:terminal_color_0 = '#4e4e4e'
    let g:terminal_color_1 = '#d68787'
    let g:terminal_color_2 = '#5f865f'
    let g:terminal_color_3 = '#d8af5f'
    let g:terminal_color_4 = '#85add4'
    let g:terminal_color_5 = '#d7afaf'
    let g:terminal_color_6 = '#87afaf'
    let g:terminal_color_7 = '#d0d0d0'
    let g:terminal_color_8 = '#626262'
    let g:terminal_color_9 = '#d75f87'
    let g:terminal_color_10 = '#87af87'
    let g:terminal_color_11 = '#ffd787'
    let g:terminal_color_12 = '#add4fb'
    let g:terminal_color_13 = '#ffafaf'
    let g:terminal_color_14 = '#87d7d7'
    let g:terminal_color_15 = '#e4e4e4'
else
    let g:terminal_ansi_colors = [
                \ '#4e4e4e', '#d68787', '#5f865f', '#d8af5f',
                \ '#85add4', '#d7afaf', '#87afaf', '#d0d0d0',
                \ '#626262', '#d75f87', '#87af87', '#ffd787',
                \ '#add4fb', '#ffafaf', '#87d7d7', '#e4e4e4'
                \ ]
endif

" See `man fzf-tmux` for available options
if exists('$TMUX')
    let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" Vim mergetool customization
" (m) - for working tree version of MERGED file
" (r) - for 'remote' revision
" common ancestor of two branches, i.e. git merge-base branchX branchY
let g:mergetool_layout = 'mr,b'
let g:mergetool_prefer_revision = 'local' " possible values: 'local' (default), 'remote', 'base'
function s:on_mergetool_set_layout(split)
    if a:split["layout"] ==# 'mr,b' && a:split["split"] ==# 'b'
        set nodiff
        set syntax=on
        resize 15
    endif
endfunction
let g:MergetoolSetLayoutCallback = function('s:on_mergetool_set_layout')

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

" set foldmethod=indent
set foldlevel=99
set tags=./tags,tags;$HOME
set autochdir
set completeopt-=preview " disable preview window
set background=dark " required by gruvbox
set bs=2
set tabstop=4
set shiftwidth=4
set expandtab
set ruler
set hidden
set nowrap
set autoindent
set smartindent
set cindent
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

inoremap jj <ESC>:w<CR>

nnoremap <C-p> :<C-u>Files<CR>
nnoremap <C-,> :<C-u>Buffers<CR>
nnoremap <C-w> :<C-u>Windows<CR>
nnoremap <C-s> :<C-u>Marks<CR>
nnoremap <C-m> :Git blame<CR>

" vim mergetooltoggle
nmap <leader>mt <plug>(MergetoolToggle)

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
    autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    autocmd FileType javascript,jsx,typescript,markdown,graphql,yaml,html,css,sass,scss,less,json AutoFormatBuffer prettier 
    autocmd FileType python AutoFormatBuffer black
    autocmd FileType vue AutoFormatBuffer prettier
augroup END

" Commenting blocks of code.
autocmd FileType c,cpp,javascript,java,scala,go let b:comment_leader = '// '
autocmd FileType sh,ruby,python      let b:comment_leader = '# '
autocmd FileType conf,fstab          let b:comment_leader = '# '
autocmd FileType tex                 let b:comment_leader = '% '
autocmd FileType mail                let b:comment_leader = '> '
autocmd FileType vim                 let b:comment_leader = '" '
noremap <silent> cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

au CursorHold * checktime
au FocusGained * :redraw!

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" colorschemes 
" Dark: monokai-chris, gruvbox
" Light: ChocolatePapaya
colorscheme badwolf

syntax on

if (has("termguicolors"))
    set termguicolors
endif
