"" Beginners .vimrc
" v0.1 2012-10-22 Philip Thrasher
"
set nocompatible
filetype off

" leader is a key that allows you to have your own "namespace" of keybindings.
" You'll see it a lot below as <leader>
let mapleader = ","

call plug#begin('~/.vim/plugged')

" hilight hex color codes
Plug 'lilydjwg/colorizer'

" Support for easily toggling comments.
Plug 'preservim/nerdcommenter' " use the ,c<space> command for commenting

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'zackhsi/fzf-tags'

"Ctags alternative should be installed outside vim (universal ctags for example)
Plug 'ludovicchabant/vim-gutentags'

"Tag bar
Plug 'majutsushi/tagbar'
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 0
nnoremap <F9> :TagbarToggle<CR>

" trailing whitespaces
Plug 'ntpeters/vim-better-whitespace'

"Start screen
Plug 'mhinz/vim-startify'

" Git show diff lines
Plug 'mhinz/vim-signify'

" tig explorer
Plug 'iberianpig/tig-explorer.vim'
Plug 'rbgrouleff/bclose.vim' " dependecy for tig
let g:tig_explorer_use_builtin_term=0

" close all buffers but current
Plug 'vim-scripts/BufOnly.vim'

" open file:line format
Plug 'bogado/file-line'

Plug 'tpope/vim-fugitive'

Plug 'junegunn/vim-easy-align'

Plug 'github/copilot.vim'

" Configurer for LSP servers, used in lua.lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Status line
Plug 'nvim-lualine/lualine.nvim'

" NerdIcons font (require nerdfont ttf files to be installed)
" SHOULD ALWAYS BE LAST
Plug 'ryanoasis/vim-devicons'

" Whichkey, helps learening vim
Plug 'folke/which-key.nvim'

" Flake8
Plug 'nvie/vim-flake8'


" All of your Plugs must be added before the following line
call plug#end()            " required

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

" Easy indent arguments on parenthesis with == see help cinoptions-values
set cino+=(0

set nowrap
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.
set nowrapscan " do not wrap around
set backspace=indent,eol,start " Fixes common backspace problems
set matchpairs+=<:> " Highlight matching pairs of brackets. Use the '%' character to jump between them.
set showmode
set showcmd
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to

set colorcolumn=100 " Highlight column 100

set clipboard=unnamedplus " Copy to system clipboard

set undofile

" We have VCS -- we don't need this stuff.
set nobackup " We have vcs, we don't need backups.
set nowritebackup " We have vcs, we don't need backups.
set noswapfile " They're just annoying. Who likes them?

" don't nag me when hiding buffers
set hidden " allow me to have buffers with unsaved changes.
set autoread " when a file has changed on disk, just load it. Don't ask.

" Show line numbers
set number
highlight LineNr ctermfg=8

" Encoding
set encoding=utf8
" Spell check
"set spell spelllang=en_us,fr

" Allow the cursor to go anywhere in visual block mode.
set virtualedit=block

" accept mistakes on wa commands
command WQ wq
command Wq wq
command W w
command Q q

" So we don't have to reach for escape to leave insert mode.
inoremap ;' <esc>
set timeoutlen=1000 ttimeoutlen=0


" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Quickly source vim
nnoremap <Leader>ve :e $MYVIMRC<cr>
nnoremap <Leader>vs :source $MYVIMRC<cr>
" Use sane regex's when searching
nnoremap / /\v
vnoremap / /\v

" Clear match highlighting
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the
" wrapped portion. This fixes that.
noremap j gj
noremap k gk


" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

" Invisible characters
"set nolist
highlight SpecialKey ctermfg=238
highlight NonText ctermfg=238

" Tab is visible
set listchars=tab:>-,trail:␠,nbsp:⎵
set list

" Line numbers

" Enable CursorLine
highlight CursorLine ctermbg=black cterm=NONE
highlight CursorLineNr ctermfg=7
set cursorline

" Search cursor color
hi Search guibg=black guifg=cyan

" Search
" set rip grep as default grep engine
set grepprg=rg\ --vimgrep

"""""""""""""""""""" Mouse """""""""""""""""""""""""""
" enable mouse controls
set mouse=a
" search for word under cursor on double click
nnoremap <silent> <2-leftMouse> *N
inoremap <silent> <2-leftMouse> <c-o>*N
" find and replace word under mouse TODO

" Clear selection on mouse click
inoremap <silent> <rightMouse> <c-o>

" keep cursor centered in middle of screen
set scrolloff=20

""""""""""""""""""Buffers"""""""""""""""""""""""""""""""
" Buffer switching like sublime
nnoremap <C-PageUp> :bp<CR>
nnoremap <C-PageDown> :bn<CR>

" Quick buffer switching - like cmd-tab'ing
nnoremap <leader><leader> <c-^>

" Buffer closing
nnoremap <leader>w :bd<CR>

" Close all other buffers except current
" leader + (shift + w)
nnoremap <leader><s-w> :BufOnly<CR>

"""""""""""""""""" vim align """"""""""""""""""""
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""""""""GUTENTAGS"""""""
lua require('vim-gutentags')

""""""" Lua StatusLine """""""
lua << EOF
local config =
{
  options = { theme = 'gruvbox' },
  sections = {
    lualine_c =
    {
        {
          'buffers',
          buffers_color = { active = { fg = '#FFFFFF'} }
        }
    }
    }
}

require('lualine').setup(config)
EOF


""""" Startify commands """""""""
" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

let g:startify_bookmarks = [ ]
let g:startify_session_persistence = 1

nnoremap <c-s> :Startify<CR>

""""""""""" TIG """"""""""""
"nnoremap <Leader>gb :TigBlame<CR>
nnoremap <Leader>gb :Git blame<CR>
" open tig with current file
nnoremap <Leader>gh :TigOpenCurrentFile<CR>
" open tig with Project root path
nnoremap <Leader>gH :TigOpenProjectRootDir<CR>

"""""""""""" FZF """"""""""""
function! s:cd(path)
    execute 'cd ' a:path
    echo a:path
endfunction

function! GSubmodules()
  return fzf#run(fzf#wrap({
  \ 'source':  "git submodule | awk '{ print $2 }' | sort -u",
  \ 'sink': function('s:cd'),
  \ 'options': ['-m', '--header-lines', !empty(expand('%')), '--prompt', 'Submodules> '],
  \}))
endfunction

nnoremap <leader>gs :Submodules<CR>

function Cd_to_submodule_parent()
  "silent !git rev-parse --is-inside-work-tree
  "if v:shell_error != 0
    "return
  "endif

  let l:parent_repo = system("git rev-parse --show-superproject-working-tree")
  if strlen(l:parent_repo) == 0
    echo "already in parent repo"
    cd `git rev-parse --show-toplevel`
  else
    echo "cd"
    execute 'cd ' l:parent_repo
  endif
endfunction

nnoremap <a-p> :GFiles<Cr>
nnoremap <C-f> :Rg<Cr>
nnoremap <leader>ff :Rg <C-R><C-W><CR>
nnoremap <leader>f :Rg <C-R><C-A>
nnoremap <leader>gp :call Cd_to_submodule_parent()<CR>
nnoremap <c-p> :call Cd_to_submodule_parent() <bar> :Files<Cr>
let g:fzf_preview_window = 'up'

"""""""Tags""""""""
" always list tags before jumping if too many
"nnoremap <c-]> g<C-]>
" use the default <c-]> behavior (see first one)
nnoremap ]t :tn<cr>
nnoremap [t :tp<cr>

" use fzf-tags plugin
nmap <a-]> <Plug>(fzf_tags)

" same but uses fzf (fzf seach in the tags file)
nnoremap <F11> :Tags<CR>
nnoremap <F10> :BTags<CR>

"""""""""""" make on vim """""""""""""""""""""""""""
" FIXME should skip warnings but doesn't work
"set errorformat^=%-G%f:%l:\ warning:%m
nnoremap ]e :cnext<CR>
nnoremap [e :cprevious<CR>

""""""""""" pdb on vim """"""""""""""""""""""""
nnoremap <leader>pb oimport ipdb; ipdb.set_trace()<Esc>

"""""""""""""""" LSP """""""""""""""""""""""""""""""
" LSP support disabled on nvim (use lvim instead)
lua require('lsp')

