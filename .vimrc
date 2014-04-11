"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
" Version:
" Sections:
"   -> general
"   -> user interface
"   -> colors and fonts
"   -> files and backups
"   -> text, tab and indent related
"   -> visual mode related
"   -> moving around, tabs and buffers
"   -> status line
"   -> editing mappings
"   -> vimgrep searching and cope displaying
"   -> spell checking
"   -> misc
"   -> helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible    " Don't be compatible with vi
filetype off        " required!

" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed..
"
" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

Plugin 'scrooloose/nerdtree'

Plugin 'Yggdroot/indentLine'
  "let g:indent_guides_guide_size = 1
  "let g:indentLine_char = '|'

Plugin 'majutsushi/tagbar'
  let g:tagbar_left = 1
  "let g:tagbar_width = 30

" Plugin 'tsaleh/vim-align'
Plugin 'godlygeek/tabular'

" Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-commentary'

Plugin 'ervandew/supertab'
  let g:SuperTabDefaultCompletionType = "context"
  "let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'

Plugin 'lilydjwg/colorizer'
  let g:colorizer_startup = 0

" Plugin 'ap/vim-css-color'
" Plugin 'gorodinskiy/vim-coloresque.git'
" Plugin 'klen/python-mode'
  " Disable pylint checking every save
  "let g:pymode_lint_write = 0
  " Set key 'R' for run python code
  "let g:pymode_run_key = 'R'
  " Choices are pyflakes, pep8, mccabe, pylint, pep257
  "let g:pymode_lint_checker = 'pyflakes,pep8'
  let g:pymode_rope_lookup_project = 0
  "let g:pymode_rope_autocomplete_map = '<C-p>'

" Plugin 'tpope/vim-rails'
" Plugin 'kchmck/vim-coffee-script'

" Plugin 'digitaltoad/vim-jade'

" Plugin 'plasticboy/vim-markdown'
  let g:vim_markdown_initial_foldlevel = 2

" Plugin 'wavded/vim-stylus'

" Plugin 'mattn/emmet-vim'
" Plugin 'spolu/dwm.vim'
" Plugin 'tpope/vim-sensible'
Plugin 'rking/ag.vim'

Plugin 'lilydjwg/fcitx.vim'

" }}}1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=1             " keep 1 context lines above and below the cursor
set sidescrolloff=5

set wildignore=*.o,*~,*.pyc " ignore these files when completing
set number                  " print the line number in front of each line
set numberwidth=1           " minimal number of column sto use for the line number

set ruler                   " show some info, even without statuslines.
set hidden                  " a buffer becomes hidden when it is abandoned

set backspace=indent,eol,start     " allow backspacing over autoindent, EOL, and BOL
set whichwrap+=<,>          " specified keys move to prev/next line at first/last char

set ignorecase              " default to using case insensitive searchs,
set smartcase               " unless uppercase letters are used in the regex.
set hlsearch                " highlight searchs by default
set incsearch               " incrementally search while typeing a /regx
set lazyredraw              " don't redraw while executing macros
set magic                   " for regular expressions turn magic on(default)

set showmatch               " briefly jump to a paren once it's braced
set matchpairs+=<:>         " show matching <> (html mainly) as well
set matchtime=2             " tenths of a second to show the matching paren

set noerrorbells
set novisualbell
set vb t_vb=                " don't bell or blink
set timeoutlen=500          " the time in milliseconds that waited for key code or mapped key sequence to complete

set foldcolumn=1            " a bit extra margin to the left
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default

" display tabs and a line runs off-screen
" set listchars=tab:>\ ,trail:-,precedes:<,extends:>,nbsp:+
" set list
"}}}1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
try
  colorscheme solarized
catch
endtry
set background=dark

if has("gui_running")
  set guioptions-=m       " no menubar
  set guioptions-=T       " no toolbar
  set t_Co=256
endif

"set termencoding=utf-8
set encoding=utf-8
set fileformats=unix,dos,mac
" For multi-byte character support (CJK)
set fileencodings=usc-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Reading/Writing
set noautowrite             " Never write a file unless I request it
set noautowriteall
set noautoread
set nobackup
set nowritebackup
set noswapfile
set cryptmethod=blowfish    " method used for encryption when the buffer is written to a file

" set backup
set backupdir=./.backup,$HOME/.backup,/tmp

set undodir=./.backup,$HOME/.backup,/tmp
set undofile
" }}}1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab               " Use spaces, not tabs, for autoindent/tab key
set smarttab                " Handle tabs more intelligently

set shiftwidth=2            " but and indent level is 2 spaces wide.
set tabstop=4               " <tab> inserts 4 space
set softtabstop=4           " <BS> over an autoindent deletes both spaces
set shiftround              " rounds indent to a multiple of shiftwidth

set linebreak               " don't wrap text in the middle of word
set textwidth=79

set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set nowrap                  " don't wrap text

if exists("&colorcolumn")
  set colorcolumn=80
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
" }}}1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set cursorline             " have a line indicate the cursor location
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext<cr>

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2            " always show statusline
"set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set statusline=%<%F\ %y\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" }}}1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ag searching and cope displaying
"    requires ag.vim{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap <silent> gv: call VisualSelection('gv', '')<CR>
map <leader>g :Ag 
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" When you search with Ag, display results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search result do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>
" }}}1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}1

" =====================================================
" FileType Specific changes{{{1
" =====================================================
augroup vimrcExt
  autocmd!

  " HTML
  autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

  "autocmd FileType coffee setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
  autocmd FileType coffee setlocal expandtab shiftwidth=2 nofoldenable

augroup END

augroup encrypted       " {{{2
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
  " We don't want a swap file, as it writes unencrypted data to disk
  autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre      *.gpg set bin
  autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost    *.gpg set nobin
  autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showcmd                 " Show incomplete normal mode commands as i type
set wildmenu
set report=0                " : commands always print changed line count
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written
"set confirm                 " Y-N-C prompt if closing with unsaved changes

"set modeline                " on(vim default)
"set modelines=5
nnoremap <silent> <Leader>ml    :call AppendModeline()<CR>
" don't outdent hashes
inoremap # #

" emac mode like keys for the command line
cnoremap <C-A>  <Home>
cnoremap <C-E>  <End>
cnoremap <C-K>  <C-U>
cnoremap <C-P>  <Up>
cnoremap <C-N>  <Down>

" Copy to X CLIPBOARD
:command -range Cz :silent :<line1>,<line2>w !xsel -i -b
:command -range Cx :silent :<line1>,<line2>w !xsel -i -p
:command -range Cv :silent :<line1>,<line2>w !xsel -i -s
:cabbrev cz Cz
:cabbrev cx Cx
:cabbrev cv Cv
" Paste from X CLIPBOARD
:command -range Pz :silent :r !xsel -o -b
:command -range Px :silent :r !xsel -o -p
:command -range Pv :silent :r !xsel -o -s
:cabbrev pz Pz
:cabbrev px Px
:cabbrev pv Pv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Append modeline after last line in buffer.
func! AppendModeline()
  let l:modeline = printf(" vim: ft=%s:et:sw=%d:ts=%d:sts=%d:tw=%d",
    \&filetype, &shiftwidth, &tabstop, &softtabstop, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfun

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("Ag \"" . l:pattern . "\" ")
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/' . l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg

endfunction

" Delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s+$//ge
  exec "normal `z"
endfunc

" Returns true if paste mode is enabled
func! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
endfun
" }}}1
