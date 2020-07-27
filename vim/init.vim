"" Beginners .vimrc
" v0.1 2012-10-22 Philip Thrasher
"
set nocompatible " Fuck VI... That's for grandpas.
filetype off

" leader is a key that allows you to have your own "namespace" of keybindings.
" You'll see it a lot below as <leader>
let mapleader = ","

call plug#begin('~/.vim/plugged')

" color schemes.
Plug 'ayu-theme/ayu-vim' " or other package manager

" hilight hex color codes
Plug 'lilydjwg/colorizer'

" Support for easily toggling comments.
Plug 'preservim/nerdcommenter' " use the ,c<space> command for commenting

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" show all buffers on top
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_b = '%-0.10{getcwd()}'

Plug 'godlygeek/tabular' " adds the Tabularize command for alignement forcing

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

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

" close all buffers but current
Plug 'vim-scripts/BufOnly.vim'

" open file:line format
Plug 'bogado/file-line'

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
set nowrapscan " do not wrap around

" allow the cursor to go anywhere in visual block mode.
set virtualedit+=block

" enable clipboard
set clipboard+=unnamedplus


" So we don't have to press shift when we want to get into command mode.
nnoremap ; :
vnoremap ; :

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

" Wrapping
set nowrap

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

" operator {Delete/change/yank..} inside next and last parenthesis 
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>

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
":autocmd InsertEnter * set cuc
":autocmd InsertLeave * set nocuc

" inspired from https://dougblack.io/words/a-good-vimrc.html#colors
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to

" easy window changing
nmap <A-Up> :wincmd k<CR>
nmap <A-Down> :wincmd j<CR>
nmap <A-Left> :wincmd h<CR>
nmap <A-Right> :wincmd l<CR>

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
nnoremap <leader><s-w> :BufOnly<CR>
""""""""""""""""""""""""""""""

" accept mistakes on wa commands
command WQ wq
command Wq wq
command W w
command Q q

" So we don't have to reach for escape to leave insert mode.
inoremap ;' <esc>
set timeoutlen=1000 ttimeoutlen=0

" enable mouse controls
set mouse=a
" search for word under cursoir on couble clik
nnoremap <silent> <2-leftMouse> *
inoremap <silent> <2-leftMouse> <c-o>*
nnoremap <c-h>  ':%s/\<'.expand('<cword>').'\>/<&>/g<CR>'

" keep cursor centered in middle of screen
set scrolloff=20

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Quickly source vim
nnoremap <Leader>ve :e $MYVIMRC<cr>
nnoremap <Leader>vs :source $MYVIMRC<cr>

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
nnoremap <F8>  :History<CR>

""""""" Vim Omni completion """""""""""""""""" REPLACED BY COC COMPLETION
"" Easier Tab completion
"function! Smart_TabComplete()
  "let line = getline('.')                         " current line

  "let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  "" line to one character right
                                                  "" of the cursor
  "let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  "if (strlen(substr)==0)                          " nothing to match on empty string
    "return "\<tab>"
  "endif
  "let has_period = match(substr, '\.') != -1      " position of period, if any
  "let has_slash = match(substr, '\/') != -1       " position of slash, if any
  "if (!has_period && !has_slash)
    "return "\<C-X>\<C-P>"                         " existing text matching
  "elseif ( has_slash )
    "return "\<C-X>\<C-F>"                         " file matching
  "else
    "return "\<C-X>\<C-O>"                         " plugin matching
  "endif
"endfunction
"""inoremap <tab> <c-r>=Smart_TabComplete()<CR>
""" Easier use of completion drop down menu
""inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
""inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
""inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
""inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
""inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

""""""""GUTENTAGS"""""""
" the last semicolon is the key here. when vim tries to locate the 'tags' file, it first looks at the current directory, then the parent directory, then the parent of the parent, and so on. this setting works nicely with 'set autochdir', because then vim's current directory is the same as the directory of the file. 

set statusline+=%{gutentags#statusline()}

let g:gutentags_trace=0

"let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/') " so no need to add ctags ignore to all projects
" this is good but abandonned because other plugins can't find them with the custom names.


"let g:gutentags_add_default_project_roots = 0
"let g:gutentags_project_root = ['package.json', '.git']
"" tags are generated on all detected root files. vim should select the appropriate tag file

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
      \ '*.idx',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'toolchain',
      \ 'compiled',
      \ 'docs',
      \ 'Documentation',
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
      \ 'Evaluation*Tools',
      \ ]

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

let g:startify_bookmarks = [ {'v': '~/repos/embedded/velux'}, {'k': '~/repos/embedded/elk'}, {'m': '~/magellan'}, {'c': '~/my_repos'} ]
let g:startify_session_persistence = 1

nnoremap <c-s> :Startify<CR>

""""""""""" TIG """"""""""""
nnoremap <Leader>gb :TigBlame<CR>
" open tig with current file
nnoremap <Leader>gh :TigOpenCurrentFile<CR>
" open tig with Project root path
nnoremap <Leader>gH :TigOpenProjectRootDir<CR>

"""""""""""" FZF """"""""""""
nnoremap <a-p> :GFiles<Cr>
nnoremap <C-f> :Rg<Cr>
nnoremap <leader>f :Rg <C-R><C-W><CR>

let g:fzf_preview_window = 'up'

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
command! -bar -bang Submodules                         call GSubmodules()

nnoremap <leader>gs :Submodules<CR>

function Cd_to_submodule_parent()

  let l:parent_repo = system("git rev-parse --show-superproject-working-tree")
  echom l:parent_repo
  if strlen(l:parent_repo) == 0
    echo "already in parent repo"
    cd `git rev-parse --show-toplevel`
  else
    execute 'cd ' l:parent_repo
  endif
endfunction
nnoremap <leader>gp :call Cd_to_submodule_parent()<CR>
nnoremap <c-p> :call Cd_to_submodule_parent() <bar> :Files<Cr>

"""""""""""" make on vim """""""""""""""""""""""""""
nnoremap ]e :cnext<CR>
nnoremap [e :cprevious<CR>

""""""""""" coc nvim """""""""""""""""'
let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-clangd',
      \ 'coc-python',
      \ 'coc-yaml',
      \ 'coc-json',
      \ 'coc-emmet',
      \ 'coc-docker',
      \ ]

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

highlight Pmenu ctermbg=gray guibg=gray

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[l` and `]l` to navigate diagnostics LINTING
nmap <silent> [l <Plug>(coc-diagnostic-prev)
nmap <silent> ]l <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap \d <Plug>(coc-definition)
nmap \y <Plug>(coc-type-definition)
nmap \i <Plug>(coc-implementation)
nmap \r <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <a-f>  <Plug>(coc-format-selected)
nmap <a-f>  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <a-s> <Plug>(coc-range-select)
xmap <silent> <a-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>n  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>p  :<C-u>CocPrev<CR>


nnoremap <leader>s :CocCommand clangd.switchSourceHeader<cr>

""" Color scheme setter
"...
set termguicolors     " enable true colors support
"let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu


