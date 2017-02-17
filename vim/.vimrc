" ================================
" File Name: vimrc
" Author: cissoid
" Created At: 2015-07-09T13:42:00+0800
" Last Modified: 2017-02-08T19:08:01+0800
" ================================
scriptencoding utf-8

" ================
" custom environment variables. {{{
" ================
" If set, use some more excellent extensions, but maybe unusable in server
" environment.
let s:enhanced = 1
" Add filetypes which could be formatted, so that Reformat() will take
" effects.
" let s:format_filetypes = []
" ================
" }}} end custom environment variables.
" ================

" ================
" powerline settings {{{
" ================
" if s:enhanced && has('python')
"     python from powerline.vim import setup as powerline_setup
"     python powerline_setup()
"     python del powerline_setup
" endif
" ================
" }}} end powerline settings.
" ================

" ================
" plugin manager settings {{{
" ================

function! TagbarHook(info)
    !go get -u 'github.com/jstemmer/gotags'
endfunction

function! YcmHook(info)
    python import os, sys, vim
    python vim.command('let l:python_executable = \'%s\'' % os.path.join(sys.exec_prefix, 'bin', 'python'))
    python del os, sys, vim
    let l:command = '!' . l:python_executable . ' install.py --clang-completer --gocode-completer --tern-completer'
    execute l:command
endfunction

call plug#begin('~/env/vim/bundle')
" themes. {{{
Plug 'tomasr/molokai'
" Plug 'altercation/vim-colors-solarized'
" }}}

" language highlight. {{{
Plug 'chikamichi/mediawiki.vim', {'for': 'wiki'}
Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'nginx.vim', {'for': 'nginx'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'solarnz/thrift.vim', {'for': 'thrift'}
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
" Plug 'blockloop/vim-swigjs', {'for': 'swig'}
" Plug 'PotatoesMaster/i3-vim-syntax', {'for': 'i3'}
" }}}

" common vim extended. {{{
Plug 'christoomey/vim-sort-motion'
" Vimdiff for directories.
Plug 'dirdiff.vim', {'on': 'DirDiff'}
" Show current search index.
Plug 'henrik/vim-indexed-search'
" Comment/uncomment.
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'
" Add extra command to handle surround symbols.
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
" Plug 'nathanaelkane/vim-indent-guides'
" }}}

" enhanced plugins. {{{
if s:enhanced
    " Show gitgutter.
    Plug 'airblade/vim-gitgutter'
    Plug 'cissoid/vim-fullwidth-punct-convertor'
    Plug 'cissoid/vim-templates'
    " Fast search file.
    Plug 'ctrlpvim/ctrlp.vim'
    " quickly jump.
    Plug 'easymotion/vim-easymotion'
    Plug 'godlygeek/tabular'
    " Singleton nerdtree.
    Plug 'jistr/vim-nerdtree-tabs', {'on': ['NERDTreeTabsToggle']}
    Plug 'junegunn/vim-easy-align'
    " Show taglist.
    Plug 'majutsushi/tagbar', {'do': function('TagbarHook')}
    Plug 'mzlogin/vim-markdown-toc', {'for': ['markdown']}
    Plug 'plasticboy/vim-markdown', {'for': ['markdown']}
    Plug 'raimondi/delimitmate'
    Plug 'rking/ag.vim'
    " File tree.
    Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeTabsToggle']}
    " Show undo tree.
    Plug 'sjl/gundo.vim', {'on': ['GundoToggle']}
    Plug 'skywind3000/asyncrun.vim'
    " Plug 'spf13/PIV', {'for': ['php']}
    " Plug 'jiangmiao/auto-pairs'
    " Plug 'terryma/vim-expand-region'
    Plug 'terryma/vim-multiple-cursors'
    " Integrated with git.
    Plug 'tpope/vim-fugitive'
    " Auto add/remove pair symbols.
    Plug 'wesQ3/vim-windowswap'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Syntax check.
    Plug 'vim-syntastic/syntastic'  " {'for': ['c', 'cpp', 'go', 'javascript', 'php', 'python', 'vim']}
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " Plug 'GlobalOptions'
    if has('python')
        " Snippet engine.
        Plug 'SirVer/ultisnips'
        " Auto completion.
        Plug 'Valloric/YouCompleteMe', {'on': ['YcmCompleter'], 'for': ['c', 'cpp', 'go', 'javascript', 'php', 'python'], 'do': function('YcmHook')}
    endif

    " Easily jump between header file and source file.
    Plug 'a.vim', {'for': ['c', 'cpp']}
    Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'swig', 'php']}
    " Plug 'fatih/vim-go'
    " Personal wiki.
    Plug 'vimwiki/vimwiki'
    " Plug 'junegunn/goyo.vim'
    " Plug 'junegunn/limelight.vim'
    " Plug 'amix/vim-zenroom2'
endif
" }}}
call plug#end()

" ================
" }}} end plugin manager
" ================

" ================
" plugin settings {{{
" ================
" gitgutter settings {{{
let g:gitgutter_max_signs = 1000
" }}}

" nerdtree settings {{{
let NERDTreeIgnore = ['\.pyc$', '\~$']
let NERDTreeCaseSensitiveSort = 1
" always change cwd when nerdtree change root node.
let NERDTreeChDirMode = 2
" show bookmarks on open.
let NERDTreeShowBookmarks = 1
" let NERDTreeShowLineNumbers = 1
" }}}

" airline settings {{{
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
" }}}

" syntastic settings, this MUST set after powerline settings. {{{
if s:enhanced
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    " let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    let g:syntastic_c_check_header = 1
    let g:syntastic_c_auto_refresh_includes = 1
    let g:syntastic_c_checkers = ['gcc', 'make', 'clang_check', 'cppcheck']
	let g:syntastic_go_checkers = ['go', 'gofmt', 'govet'] " golint
    let g:syntastic_python_checkers = ['python', 'flake8']
    " let g:syntastic_python_flake8_args = '--ignore=E402,E501'
    " let g:syntastic_python_checkers = ["pylint"]
    " let g:syntastic_python_pylint_post_args = '--msg-template="{path}:{line}:{column}:{C}: [{symbol} {msg_id}] {msg}"'
    " let g:syntastic_python_pylint_args = '--disable=C0103,C0111,C0411,C0412,C0413,R0201'
    " let g:syntastic_python_flake8_quiet_messages = {
    "     \ 'type': 'style',
    "     \ 'regex': '\s(E401)\s'
    "     \ }
    let g:syntastic_css_checkers = ['csslint', 'recess', 'stylelint']
    let g:syntastic_javascript_checkers = ['eslint'] " jslint, jshint, standard
    let g:syntastic_markdown_checkers = ['textlint']
    let g:syntastic_sh_shellcheck_args = '-x -eSC1090,SC1091'
    let g:syntastic_vim_checkers = ['vint']
    let g:syntastic_php_checkers = ['php', 'phpcs']
    let g:syntastic_php_phpcs_args = '--standard=PSR1,PSR2'
endif
" }}}

" ycm settings {{{
if s:enhanced
    let g:ycm_min_num_of_chars_for_completion = 1
    let g:ycm_complete_in_comments = 1
    let g:ycm_complete_in_strings = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_key_invoke_completion = '<Leader>y<Space>'
    let g:ycm_key_detailed_diagnostics = '<Leader>yd'
    let g:ycm_key_list_select_completion = ['<Tab>', '<C-j>']
    let g:ycm_key_list_previous_completion = ['<C-k>']
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    let g:ycm_confirm_extra_conf = 0
    " disable this to make syntastic work correctly.
    let g:ycm_show_diagnostics_ui = 0
endif
" }}}

" ultisnips settings {{{
if s:enhanced
    let g:UltiSnipsExpandTrigger = '<C-l>'
    let g:UltiSnipsJumpForwardTrigger = '<C-l>'
    let g:UltiSnipsJumpBackwordTrigger = '<C-h>'
endif
" }}}

" tagbar settings {{{
if s:enhanced
    let g:tagbar_sort = 0
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }
endif
" }}}

" ctrlp settings {{{
if s:enhanced
    " show window in bottom, and sort from top to bottom.
    let g:ctrlp_match_window = 'bottom,order:ttb'
    " open match file in new buffer.
    let g:ctrlp_switch_buffer = 0
    " support change working directory.
    let g:ctrlp_working_path_mode = 0
    " use ag to speed up.
    if executable('ag')
        let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
        let g:ctrlp_use_caching = 0
    endif
endif
" }}}

" nerdcommenter settings {{{
if s:enhanced
    " Add extra space after comment character.
    let NERDSpaceDelims = 1
    let NERDRemoveExtraSpaces = 1
    let g:NERDCustomDelimiters = {
        \ 'python': {'left': '#', 'leftAlt': '#'}
        \ }
endif
" }}}

" emmet settings {{{
if s:enhanced
    let g:user_emmet_install_global = 0
endif
" }}}

" windowswap settings {{{
if s:enhanced
    let g:windowswap_map_keys = 0
endif
" }}}

" vim-go settings {{{
if s:enhanced
    let g:go_fmt_fail_silently = 1
    let g:go_list_type = 'quickfix'
endif
" }}}

" vimwiki settings {{{
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [
    \ {'path': '~/Dropbox/Personal/wiki/', 'syntax': 'markdown', 'ext': '.md', 'auto_toc': 1}
    \ ]
" }}}

" goyo & limelight settings {{{
" let g:limelight_conceal_ctermfg = 'gray'
" let g:limelight_conceal_guifg = 'DarkGray'
" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!
" }}}

" vim-markdown settings {{{
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_toc_autofit = 1
" }}}
"

" ================
" }}} end plugin settings
" ================

" ================
" base settings {{{
" ================
" set encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,gbk,default,latin1
" improved.
set nocompatible
" enable filetype detection.
filetype on
filetype plugin on
filetype plugin indent on
" ignore error bells.
set noerrorbells
set novisualbell
set t_vb=
" OSX seems don't have own backspace setting.
set backspace=indent,eol,start

" color setting {{{
syntax enable
" enable true color for terminal.
" set termguicolors
" colorful!
" set background=dark
colorscheme molokai
" let g:solarized_termcolors=256
" colorscheme solarized
" }}}

" ui setting {{{
" show filename and other infos.
set title
" always show tab line.
set showtabline=2
" always show status line.
set laststatus=2
" don't show default mode line(above status line).
set noshowmode
" show line number.
set number
set relativenumber
" show command in bottom bar, no use for powerline.
set showcmd
" highlight current line.
set cursorline
set cursorcolumn
" show a menu for filename autocomplete.
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.swp,*.bak,*.pyc,*.pyo,*.class,*.zip
" lazy redraw.
set lazyredraw
" improves smoothness of redrawing.
set ttyfast
" show the matching part of the pair for [] {} and ()
set showmatch
" set text width
set textwidth=0
" set ambiwidth=double
" highlight the long text
set colorcolumn=80,120
set ruler
set scrolloff=10
" invisible char when exec :list
" set list
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:»,precedes:«
" }}}

" gui setting {{{
if has('gui_running')
    if has('macunix')
        " set guifont=Ubuntu\ Mono\ derivative\ Powerline:h16
        set guifont=Consolas:h15
        set guioptions=
    elseif has('unix')
        set guifont=Monospace\ 12
        set guioptions=
    endif
else
    set t_Co=256
    highlight Normal ctermbg=none
endif
" }}}

" tab & space & indent setting. {{{
" number of visual spaces for tab.
set tabstop=4
" number of actual spaces for tab.
set softtabstop=4
" make << or >> step 4 spaces.
set shiftwidth=4
" convert tab to spaces.
set expandtab
" set smarttab
" auto indent.
set autoindent
" set smartindent
" }}}

" search setting. {{{
" highlight matches.
set hlsearch
" search ignore case.
set ignorecase
" incremantal search.
set incsearch
" }}}

" folding setting {{{
" enable fold
set foldenable
" fold based on indent level.
set foldmethod=indent
" 10 fold when open file.
set foldlevelstart=10
set foldlevel=99
" 10 nest fold max.
set foldnestmax=10
" }}} 
" ================
" }}} end base settings
" ================

" ================
" custom functions. {{{
" ================
" function! s:AddReformatLang(filetypes)
"     if (type(a:filetypes) == 3) " expect list
"         call extend(s:format_filetypes, a:filetypes)
"     elseif (type(a:filetypes) == 1) " expect string
"         call add(s:format_filetypes, a:filetypes)
"     endif
" endfunction

function! Reformat()
    if (&formatprg !=# '')
    " if (index(s:format_filetypes, &filetype) >= 0)
        " mark current location
        silent! normal! mm
        " format all
        silent! normal! gggqG
        " move cursor back
        silent! normal! 'm
        " clear mark
        silent! execute 'delmarks m'
        " center current line
        silent! normal! zz
    endif
endfunction

" capture shell output and display in a window.
function! s:ExecuteInShell(command)
    let l:command = join(map(split(a:command), 'expand(v:val)'))
    let l:winnr = bufwinnr('^' . l:command . '$')
    silent! execute  l:winnr < 0 ? 'botright new ' . fnameescape(l:command) : l:winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
    echo 'Execute ' . l:command . '...'
    silent! execute 'silent %!'. l:command
    silent! execute 'resize ' . max([line('$'), 5])
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    " silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . l:command . ''')<CR>'
    echo 'Shell command ' . l:command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

command! SudoW :w !sudo tee % >/dev/null
" ================
" }}}
" ================

" ================
" keymap settings {{{
" ================
" let mapleader=","

" nmap {{{
" hard mode
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
" move vertically by screen line.
nnoremap <silent> <expr> j (v:count == 0 ? 'gj': 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk': 'k')
" space = toggle folding.
nnoremap <Space> za
" highlight last inserted text
" nnoremap gV `[v`]
" actually it map to Ctrl+/. See
" http://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim.
" nmap <C-_> <Plug>NERDCommenterToggle
"
" nnoremap <Leader>s :mksession<CR>
" nnoremap <Leader>a :Ag 
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
" reopen .vimrc after source, otherwise filetype specific settinsg will not
" work.
nnoremap <Leader>sv :w<CR>:source $MYVIMRC<CR>:q<CR>
" nnoremap <C-n> :tabnew<CR>

nnoremap <S-j> <C-d>
nnoremap <S-k> <C-u>
nnoremap <C-j> j<C-e>
nnoremap <C-k> k<C-y>

nnoremap <Leader>% :vsplit<CR>
nnoremap <Leader>" :split<CR>

nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>
nnoremap gP :set paste!<CR>

if s:enhanced
    nnoremap <Leader>n :NERDTreeToggle<CR>
    nnoremap <Leader>u :GundoToggle<CR>
    nnoremap <Leader>t :TagbarToggle<CR>
    nnoremap <Leader>gt :TagbarOpen('j')<CR>
    nnoremap <Leader>ss :SyntasticReset<CR>
    nnoremap <Leader>sw :call WindowSwap#EasyWindowSwap()<CR>
    nnoremap <Leader>yg :YcmCompleter GoTo<CR>
    nnoremap <Leader>yt :YcmCompleter GetType<CR>
    nnoremap <Leader>yd :YcmCompleter GetDoc<CR>
    nnoremap <Leader>w<Space> :VimwikiToggleListItem<CR>
    nnoremap <Leader>fa :call Reformat()<CR>
    nmap ga <Plug>(EasyAlign)
endif
" }}}

" imap {{{
" hard mode
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Esc> <Nop>
inoremap jk <Esc>

if s:enhanced
    inoremap <Leader>yt :YcmCompleter GetType<CR>
endif
" }}}

" vmap {{{
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
" vnoremap <Esc> <Nop>
" vnoremap jk <Esc>
if s:enhanced
    vnoremap ga <Plug>(EasyAlign)
endif
" }}}
" ================
" }}} end keymap settings
" ================

" ================
" filetype specific settings. {{{
" move these config into ftplugin folder seems better, but not necessary for me
" now.
" ================

" augroup filetype_dotfiles
"     autocmd!
"     autocmd FileType vim setlocal foldmethod=marker foldlevel=0
"     autocmd FileType sh setlocal foldmethod=marker foldlevel=0
" augroup END

augroup filetype_python
    autocmd!
    " enable all Python syntax highlighting features
    autocmd FileType python let python_highlight_all = 1

    if s:enhanced
        autocmd BufEnter * if &filetype ==# 'python' | set formatprg=autopep8\ \- | endif
        autocmd BufLeave * if &filetype ==# 'python' | set formatprg= | endif
        " autocmd FileType python,pyrex SetBufferLocal formatprg=yapf\ \-\-
    endif
augroup END

augroup filetype_clang
    autocmd!

    if s:enhanced
        autocmd BufEnter * if index(['c', 'cpp'], &filetype) >= 0 | set formatprg=clang\-format\ \-style=\"\{BasedOnStyle:\ Google,\ IndentWidth:\ 4\}\" | endif
        autocmd BufLeave * if index(['c', 'cpp'], &filetype) >= 0 | set formatprg= | endif
    endif
augroup END

augroup filetype_golang
    autocmd!
    if s:enhanced
        autocmd BufEnter * if &filetype ==# 'go' | set formatprg=gofmt | endif
        autocmd BufLeave * if &filetype ==# 'go' | set formatprg= | endif

        autocmd FileType go nnoremap <F9> :Shell go build %<CR>
        autocmd FileType go nnoremap <F10> :Shell go run %<CR>
    endif
augroup END

augroup filetype_rust
    autocmd!
    if s:enhanced
        autocmd BufEnter * if &filetype ==# 'rust' | set formatprg=rustfmt | endif
        autocmd BufLeave * if &filetype ==# 'rust' | set formatprg= | endif
    endif
augroup END

augroup filetype_html
    autocmd!
    if s:enhanced
        autocmd FileType html EmmetInstall
        autocmd BufEnter * if &filetype ==# 'html' | set formatprg=js\-beautify\ \-\-type\ html | endif
        autocmd BufLeave * if &filetype ==# 'html' | set formatprg= | endif
    endif
augroup END

augroup filetype_css
    autocmd!
    if s:enhanced
        autocmd FileType css EmmetInstall
        autocmd BufEnter * if &filetype ==# 'css' | set formatprg=js\-beautify\ \-\-type\ css | endif
        autocmd BufLeave * if &filetype ==# 'css' | set formatprg= | endif
        autocmd BufEnter * if &filetype ==# 'scss' | set formatprg=sass\-convert\ \-\-indent\ 4\ \-\F\ scss\ \-T\ scss | endif
        autocmd BufLeave * if &filetype ==# 'scss' | set formatprg= | endif
        autocmd BufEnter * if &filetype ==# 'sass' | set formatprg=sass\-convert\ \-\-indent\ 4\ \-\F\ sass\ \-T\ sass | endif
        autocmd BufLeave * if &filetype ==# 'sass' | set formatprg= | endif
    endif
augroup END

augroup filetype_javascript
    autocmd!
    if s:enhanced
        autocmd BufEnter * if &filetype ==# 'javascript' | set formatprg=js\-beautify | endif
        autocmd BufLeave * if &filetype ==# 'javascript' | set formatprg= | endif
    endif
augroup END

augroup filetype_php
    autocmd!
    if s:enhanced
        autocmd FileType php EmmetInstall
        autocmd BufEnter * if &filetype ==# 'php' | set formatprg=phpcbf\ \-\-stdin\-path\ \-\-standard\=PSR1,PSR2 | endif
        autocmd BufLeave * if &filetype ==# 'php' | set formatprg= | endif
    endif
augroup END

" ================
" }}}
" ================

" vim: foldmethod=marker foldlevel=0