" => Vundle plugin manager {{{1
set nocompatible                                " Required
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself.
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'tpope/vim-commentary'
Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-repeat'

Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
" Plugin 'kien/ctrlp.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
" Plugin 'rking/ag.vim'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'christoomey/vim-tmux-navigator'

Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'Yggdroot/indentLine'

Plugin 'vim-scripts/lastpos.vim'

" Plugin 'noahfrederick/vim-skeleton'

" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'

Plugin 'nvie/vim-flake8'
Plugin 'davidhalter/jedi-vim'

" Color schemes
Plugin 'altercation/vim-colors-solarized'
" Plugin 'chriskempson/base16-vim'

" Required, plugins available after.
call vundle#end()
filetype plugin indent on
" }}}1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Basic Settings {{{1
syntax on                                       " syntax highlighting
filetype on                                     " try to detect filetype
filetype plugin indent on                       " enable loading indent file for filetype
set number                                      " display line number
set numberwidth=5
set background=dark                             " using dark background in vim
" set title                                       " show title in console title bar
set wildmenu                                    " menu completion in command mode on <Tab>
set wildmode=longest,list                       " <Tab> cycles

set wildignore+=*.o,*.obj,.git,*.pyc            " ignore files when completing
set wildignore+=eggs/*
set wildignore+=*.egg-info/**

set grepformat=%f:%l:%c:%m
if executable('ack')
    set grepprg=ack\ --nogroup\ --nocolor\ --column\ --smart-case\ --follow\ $*
endif
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --column\ --smart-case\ --follow
endif
set hidden                                      " hidden buffer when it s abandoned
set history=1024
set mouse=
" set noshowmode
" set noexrc
set ttyfast
set ttymouse=xterm2

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6                                 " keep a small completion window

""" Moving Around/Editing
" set cursorline                                  " have a line indicate the cursor location
set nostartofline                               " avoid moving cursor to BOL when jumping around
set virtualedit=block                           " let cursor move past the last char in <C-v> mode
set scrolloff=3                                 " keep 3 context lines above and below the cursor
" set backspace=2                                 " allow backspacing over autoindent, EOL, and BOL
set backspace=indent,eol,start
set more
set showmatch                                   " briefly jump to a paren once it's balanced
set matchpairs+=<:>                             " show match <> (html mainly) as well
set matchtime=2                                 " tenths of second to show the matching paren
set nowrap                                      " don't wrap text
set linebreak                                   " don't wrap text in the middle of a word
set autoindent                                  " always set autoindenting on
set smartindent                                 " use smart indent if there is no indent file

set tabstop=4                                   " <tab> inserts 4 spaces
set shiftwidth=4                                " but an indent level is 2 spaces wide.
set softtabstop=4                               " <BS> over an autoindenting deletes both spaces.
set expandtab                                   " use spaces, not tabs, for autoindent/tab key.
set smarttab                                    " handle tabs more intelligently

set shiftround                                  " rounds indent to a multiple of shiftwidth
set cinkeys-=0#
set nrformats+=alpha
set splitbelow                                  " spliting a window below the current one
set splitright                                  " spliting a window right the current one

set foldmethod=indent                           " allow us to fold on indents
set foldlevel=99                                " don't fold by default
set foldcolumn=0
set foldnestmax=10
set foldlevelstart=99

" don't outdent hashes
inoremap # #

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" return to last position when opening files {{{2
" autocmd BufReadPost *
"     \ if line("'\"") > 0 && line("'\"") <= line("$") |
"     \   exe "normal! g`\"" |
"     \ endif
" }}}2

"""" Reading/Writing
set noautowrite                                 " never write a file unless I request it.
set noautowriteall                              " NEVER."
set noautoread                                  " don't automatically re-read changed files.
set modeline                                    " allow vim options to be embedded in files.
set modelines=5                                 " they must be within the first or last 5 lines
set fileformats=unix,dos,mac                    " try recognizing dos, unix, and mac line endings.
set fileencodings=usc-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" set updatecount=32
set nobackup                                    " not do a backup before overwriting a file
set cryptmethod=blowfish
if has('persistent_undo') && exists("&undodir")
    set undodir=./.backup,$HOME/.backup,/tmp
    set undofile
    set undolevels=1024
    set undoreload=8192
endif

"""" Messages, Info, Status
set laststatus=2                                " allways show status line
set ruler                                       " show some info, even without statuslines.
set noerrorbells                                " don't bell or blink
set vb t_vb=                                    " disable all bells
set confirm                                     " Y-N-C prompt if closing with unsaved changes.
set showcmd                                     " show incomplete normal mode commands as i type.
set report=0                                    " : commands always print changed line count.
set shortmess+=a                                " use [+]/[RO]/[w] for modified/readonly/written.
set lazyredraw

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,trail:¬,precedes:<,extends:>,nbsp:+
set list

""" Searching and Patterns
set incsearch                                   " incrementally search while type a /regex
set hlsearch                                    " highlight searches by default.
" set gdefault
set ignorecase                                  " default to using case insensitive searches,
set smartcase                                   " unless uppercase letters are used in the regex.
set wrapscan

set colorcolumn=79
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

""" Display
if (&term =~ "xterm") || (&term =~ "screen")
    set t_Co=256                                " 256 colors
endif
if has("gui_running")
    set guioptions-=m
    set guioptions-=T
endif
if &t_Co >=256
    colorscheme solarized
    " colorscheme base16-default
else
    colorscheme default
endif

" }}}1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FileType specific changes  {{{1

autocmd FileType yaml setlocal expandtab ts=2 sw=2 fenc=utf-8

augroup encrypted           " {{{2
    autocmd!
    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
    " We don't want a swap file, as it writes unencrypted data to disk
    autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre      *.gpg set bin
    autocmd BufReadPre,FileReadPre      *.gpg let ch_save=&ch|set ch=2
    autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost    *.gpg set nobin
    autocmd BufReadPost,FileReadPost    *.gpg let &ch=ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

    " Convert all text to encrypted text before writing
    autocmd BufWritePre,FileWritePre    *.gpg set bin
    autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost  *.gpg silent u
    autocmd BufWritePost,FileWritePost  *.gpg set nobin

    " Fold entries by default
    autocmd BufReadPre,FileReadPre      *.gpg set foldmethod=expr
    autocmd BufReadPre,FileReadPre      *.gpg set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
augroup END
" }}}2

" }}}1

""" => Keybindings {{{1
let mapleader=","

" paste from clipboard
map <Leader>p "+p

" hide matches on <Leader>space
nnoremap <Leader><Space> :nohlsearch<CR>

" remove trailing whitespace on <Leader>S
nnoremap <Leader>S :%s/\s\+$//<CR>:let @/=''<CR>

" select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" add a  modeline
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Move faster
" map <C-j> <C-D>
" map <C-k> <C-u>

" nnoremap ci( %ci(
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Buffers, preferred over tabs now with bufferline
nnoremap gn :bnext<CR>
nnoremap gN :bprev<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
nnoremap gd :bdelete<CR>
nnoremap gf <C-^>

" copy to X CLIPBOARD
command! -range Cz :silent :<line1>,<line2>w !xsel -i -b
command! -range Cx :silent :<line1>,<line2>w !xsel -i -p
command! -range Cv :silent :<line1>,<line2>w !xsel -i -s
cabbrev cz Cz
cabbrev cx Cx
cabbrev cv Cv
" paste from X CLIPBOARD
command! -range Pz :silent :r !xsel -o -b
command! -range Px :silent :r !xsel -o -p
command! -range Pv :silent :r !xsel -o -s
cabbrev pz Pz
cabbrev px Px
cabbrev pv Pv
" }}}1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin config {{{1
" tagbar
let g:tagbar_left=1
" let g:tagbar_width=30
let g:tagbar_sort=0

" ag
let g:agprg = 'ag --column'

" ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif

" easymotion {{{2
" let g:EasyMotion_do_mapping = 0                 " Disable default mappings
" let g:EasyMotion_smartcase = 1                  " Turn on case sensitive feature
" let g:EasyMotion_startofline = 0                " keep cursor colum when JK motion
" let g:EasyMotion_use_smartsign_us = 1           " Smartsig
" map <Leader> <Plug>(easymotion-prefix)
" nmap s <Plug>(easymotion-s2)
" nmap t <Plug>(easymotion-t2)
" nmap f <Plug>(easymotion-f2)
" nmap T <Plug>(easymotion-T2)
" nmap F <Plug>(easymotion-F2)
" map / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map n <Plug>(easymotion-next)
" map N <Plug>(easymotion-prev)
" map <Leader>l <Plug>(easymotion-lineforward)
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
" map <Leader>h <Plug>(easymotion-linebackward)
" }}}

" unite{{{2
" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_mru', 'matchers', ['matcher_project_files', 'matcher_fuzzy'])
call unite#custom#source('file_rec,file_rec/async,file_rec/git,file_mru,file,buffer,grep',
    \ 'ignore_pattern', join([
    \ '\.swp', '\.swo', '\~$',
    \ '\.git/', '\.svn/', '\.hg/',
    \ '\.ropeproject/',
    \ '/vendor/gems/', '/vendor/cache/', '\.bundle/', '\.sass-cache/',
    \ '\.o$', '\.out$', '\.obj$',
    \ '\.pyc$', '__pycache__/',
    \ '\.class$', '\.jar$',
    \ '\.jpg$', '\.jpeg$', '\.bmp$', '\.png$', '\.gif$',
    \ '\.zip$', '\.tar\.gz$', '\.tar\.bz2$', '\.rar$', '\.tar\.xz$',
    \ '\.doc$', '\.docx$',
    \ 'target/',
    \ ], '\|'))

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--line-numbers --nocolor --nogroup --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
endif

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Play nice with supertab
    let b:SuperTabDisable = 1
    " Enable navigation with control-j/k in insert mode
    imap <silent><buffer> <C-j> <Plug>(unite_select_next_line)
    imap <silent><buffer> <C-k> <Plug>(unite_select_previous_line)
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    imap <silent><buffer><expr> <C-s> unite#do_action('split')
    imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

    let unite = unite#get_current_unite()
    if unite.profile_name ==# '^search'
        nnoremap <silent><buffer><expr> r unite#do_action('replace')
    else
        nnoremap <silent><buffer><expr> r unite#do_action('rename')
    endif
endfunction

nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap ; [unite]
xmap ; [unite]

" Source
nnoremap <silent> [unite]u :<C-u>Unite -silent -vertical -buffer-name=source source<CR>
" Buffer
nnoremap <silent> [unite]b :<C-u>Unite -silent -buffer-name=buffer buffer file_mru bookmark<CR>
" File List
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -silent -buffer-name=files file<CR>
" Register List
nnoremap <silent> [unite]R :<C-u>Unite -silent -buffer-name=register register<CR>
" Restore Unite
nnoremap <silent> [unite]r :<C-u>UniteResume<CR>
" Yank History
let g:unite_source_history_yank_enable = 1
nnoremap <silent> [unite]y :<C-u>Unite -silent -buffer-name=yanks history/yank<CR>
" Show Mapping List
nnoremap <silent> [unite]ma :<C-u>Unite -silent mapping<CR>
" Show Message
nnoremap <silent> [unite]me :<C-u>Unite -silent output:message<CR>
" Jump (mnemonic: <C-o> jump to Older cursor position)
nnoremap <silent> [unite]<C-o> :<C-u>Unite -silent change jump<CR>
" Grep
nnoremap <silent> [unite]gr :<C-u>Unite -silent -no-quit -buffer-name=search grep:.<CR>
" Line
nnoremap <silent> g/ :<C-u>Unite -no-quit -start-insert -buffer-name=search line<CR>
" Execute help
" nnoremap <silent> [unite]gh :<C-u>Unite -silent -buffer-name=help help -start-insert<CR>
 " Fold
" nnoremap <silent> [unite]z :<C-u>Unite -silent fold -vertical -winwidth=40 -no-start-insert<CR>
" Unite Beautiful Atack
" nnoremap <silent> [unite]C :<C-u>Unite -auto-preview colorscheme<CR>
" Git repository
nnoremap <silent> [unite]<Space> :<C-u>Unite -buffer-name=files file_rec/async:! -start-insert<CR>
nnoremap <silent> <Space><Space> :<C-u>Unite -buffer-name=files file_rec/git -start-insert<CR>

" nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir -buffer-name=files buffer bookmark file<CR>
" " nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
" nnoremap <silent> [unite]s :<C-u>Unite -no-split -buffer-name=files jump_point file_point buffer_tab file_rec:! file file/new<CR>

" file search like ctrlp.vim
" nnoremap <silent> <C-p> :<C-u>Unite -buffer-name=files file_rec/async:! -start-insert<CR>
" nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search line:forward -start-insert grep:.<CR>
" }}}2

" skeleton {{{2
let g:skeleton_template_dir = "~/.vim/skeleton"
" }}}

" flake8
let g:flake8_max_line_length = 99

" neocomplete {{{2
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase
" let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length
let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
" }}}2

" neosnippet {{{2
" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: "\<TAB>"
" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
" Enable snipMate compatibility feature
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell neosnippet about the other snippets
let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'
" }}}2

" jedi
let g:jedi#popup_select_first = 0

" airline {{{2
let g:airline#extensions#tabline#enabled=1
" let g:airline#extensions#tabline#left_sep=' '
" let g:airline#extensions#tabline#right_sep='|'
if &term != 'linux'
    let g:airline_powerline_fonts = 1
endif
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

" let g:airline_symbols.paste = 'PASTE'
" let g:airline_symbols.readonly = "\ue0a2"
" let g:airline_symbols.whitespace = "\u2739"
" let g:airline_symbols.linenr = "\ue0a1"
" let g:airline_symbols.branch = "\ue0a0"
" }}}2


" }}}1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" helper functions {{{1

" my helper {{{2

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

" }}}2

" }}}1
