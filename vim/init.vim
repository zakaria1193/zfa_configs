" Beginners .vimrc
" v0.1 2012-10-22 Philip Thrasher
"
" Setup Vundle:
" For this to work, you must install the vundle plugin manually.
" https://github.com/gmarik/vundle
set nocompatible " Fuck VI... That's for grandpas.
filetype off

" leader is a key that allows you to have your own "namespace" of keybindings.
" You'll see it a lot below as <leader>
let mapleader = ","

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

" Vundle let's you specify a plugin in a number of formats, but my favorite
" allows you to grab plugins straight off of github, just specify the bundle
" in the following format:
" Bundle 'githubUsername/repoName'

" Let vundle manage itself:
Bundle 'gmarik/vundle'

" color schemes.
Bundle 'rainglow/vim'
"colorscheme bold-contrast


Plugin 'lilydjwg/colorizer'

" Support for easily toggling comments.
Plugin 'preservim/nerdcommenter' " use the ,c<space> command for commenting

" Proper JSON filetype detection, and support.
Bundle 'leshill/vim-json'

" vim indents HTML very poorly on it's own. This fixes a lot of that.
Bundle 'indenthtml.vim'

" I write markdown a lot. This is a good syntax.
Bundle 'tpope/vim-markdown'

Plugin 'preservim/nerdtree'

Plugin 'chrisbra/csv.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" show all buffers on top
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

Plugin 'godlygeek/tabular' " adds the Tabularize command for alignement forcing

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Plugin 'ycm-core/YouCompleteMe' "Autocomplete

"Ctags alternative should be installed outside vim (universal ctags for example)
Plugin 'ludovicchabant/vim-gutentags'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" We have to turn this stuff back on if we want all of our features.
filetype plugin indent on " Filetype auto-detection
syntax on " Syntax highlighting

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
set smartindent " Intellegently dedent / indent new lines based on rules.

" spell check
"set spell spelllang=en_us

" We have VCS -- we don't need this stuff.
set nobackup " We have vcs, we don't need backups.
set nowritebackup " We have vcs, we don't need backups.
set noswapfile " They're just annoying. Who likes them?

" don't nag me when hiding buffers
set hidden " allow me to have buffers with unsaved changes.
set autoread " when a file has changed on disk, just load it. Don't ask.

" Make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.

" allow the cursor to go anywhere in visual block mode.
set virtualedit+=block


" So we don't have to press shift when we want to get into command mode.
nnoremap ; :
vnoremap ; :

" create new vsplit, and switch to it.
noremap <leader>v <C-w>v

" Use sane regex's when searching
"nnoremap / /\v
"vnoremap / /\v

" Clear match highlighting
noremap <leader><space> :noh<cr>:call clearmatches()<cr>



" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the
" wrapped portion. This fixes that.
noremap j gj
noremap k gk

" Fixes common backspace problems
set backspace=indent,eol,start

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list

" Show line numbers
set number

" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Automatically save and load folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview"

" Invisible characters
set list
set listchars=eol:$,tab:··,trail:·,extends:>,precedes:<
highlight SpecialKey ctermfg=238
highlight NonText ctermfg=238
" Line numbers
highlight LineNr ctermfg=8

" Enable CursorLine
highlight CursorLine ctermbg=235 cterm=NONE
highlight CursorLineNr ctermfg=7
set cursorline

" Enable cursorcolumn in insert mode
:autocmd InsertEnter * set cuc
:autocmd InsertLeave * set nocuc

" inspired from https://dougblack.io/words/a-good-vimrc.html#colors
set wildmenu            " visual autocomplete for command menu
"set lazyredraw          " redraw only when we need to

" Nerd tree auto follow
function MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

nnoremap <C-n> :call MyNerdToggle()<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" set rip grep as default grep engine
set grepprg=rg\ --vimgrep

" auto set buffer's dir as vim dir
"autocmd BufEnter * silent! lcd %:p:h

""""""""""""""""""Buffers"""""""
" Buffer switching like sublime
nnoremap <C-PageUp> :bp<CR>
nnoremap <C-PageDown> :bn<CR>

" Quick buffer switching - like cmd-tab'ing
nnoremap <leader><leader> <c-^>

" Buffer closing 
nnoremap <leader>w :bd<CR>
""""""""""""""""""""""""""""""

" accept mistakes on wa commands
command WQ wq
command Wq wq
command W w
command Q q

" fast escape of insert mode with esc his will break any sequences using escape in insert mode.
":set noesckeys " BREAKS ARROW KEYS AND DOESNT FIX ESCAPE

" So we don't have to reach for escape to leave insert mode.
inoremap ;' <esc>
set timeoutlen=1000 ttimeoutlen=0

" enable mouse controls
"set ttymouse=sgr "without that you'll need to set TERM to TERM=xterm-256colorm doesnt seem to work with nvim
set mouse=a
inoremap <LeftMouse> <Esc><LeftMouse> 

" keep cursor centered in middle of screen:wq
:set scrolloff=20

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>

" Quickly source vim
nnoremap <Leader>ve :e $MYVIMRC<cr>
nnoremap <Leader>vs :source $MYVIMRC<cr>

"""""""Tags""""""""
"search for tags file in parent dire too
"set tags+=tags;/
"no used since gutentags puts the tags file in his cache

" always list tags before jumping if too many
nnoremap <C-]> g<C-]>

""""""" YOU COMPLETE ME """"""""""""""""""
"let g:ycm_collect_identifiers_from_tags_files = 1
""""""" Vim Omni completion """"""""""""""""""
" Easier Tab completion
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction
inoremap <tab> <c-r>=Smart_TabComplete()<CR>
" Easier use of completion drop down menu
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

""""""""FZF"""""""
nnoremap <C-p> :GFiles<Cr>
nnoremap g<C-p> :Files<Cr>
nnoremap <C-h> :History<Cr>
nnoremap <C-f> :Rg<Cr>

nnoremap <leader>t :BTags<Cr>
nnoremap <leader>gt :Tags<Cr>

""""""""GUTENTAGS"""""""
set statusline+=%{gutentags#statusline()}

let g:gutentags_trace=0
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/') " so no need to add ctags ignore to all projects
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
"Make gutentags faster
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ '*.bin',
      \ '*.elf',
      \ '*.S',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]