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
            \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'psf/black', { 'branch': 'stable' }
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

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
set clipboard=unnamedplus " System clipboard integration
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
colorscheme tokyonight

let g:tokyonight_style = "storm"  " or 'night' or 'day'
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

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s)
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:mergetool_layout = 'mr,b'
let g:mergetool_prefer_revision = 'local' " possible values: 'local' (default), 'remote', 'base'
let g:MergetoolSetLayoutCallback = function('s:on_mergetool_set_layout')

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 50
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

" let g:pymode_python = 'python3'

augroup StartupLayout
    autocmd!
    autocmd VimEnter * doautocmd User VimStartupDone
    autocmd User VimStartupDone call SetupLayout()
augroup END

" Format automatically
augroup autoformat_settings
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,sass,scss,less AutoFormatBuffer js-beautify
    autocmd FileType javascript,jsx,typescript,markdown,graphql,yaml,html,css,sass,scss,less AutoFormatBuffer prettier 
    autocmd FileType python AutoFormatBuffer black
    autocmd FileType vue AutoFormatBuffer prettier
augroup END

" Commenting blocks of code.
augroup comment_file
    autocmd FileType c,cpp,javascript,java,scala,go let b:comment_leader = '// '
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
