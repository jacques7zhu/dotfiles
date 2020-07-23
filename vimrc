set nocompatible              " be iMproved, required

" auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter' " show git diff in sign column
Plug 'tpope/vim-abolish' " case preserving replace
"Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround' " change surroundings
Plug 'ctrlpvim/ctrlp.vim' " fuzzy file finder
Plug 'tpope/vim-repeat' " optimize .
Plug 'drmikehenry/vim-headerguard' "add header guard
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
" The bang version will try to download the prebuilt binary if cargo does not exist.
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
Plug 'ThePrimeagen/vim-be-good'
Plug 'w0rp/ale'

call plug#end()

filetype plugin indent on    " required

" securities for custom .vimrc
set exrc
set secure

" find files in subfolders
set path+=**

" keymaps
let mapleader = " "
inoremap jj <ESC>
map <silent> <leader>n :NERDTreeToggle<CR>
map <silent> <leader>N :NERDTree<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap Y y$
nnoremap <C-S> :w<CR>
nnoremap X :x<CR> " save and close
nnoremap <F4> oimport ipdb<CR>ipdb.set_trace()<CR><ESC> " map F4 to insert ipdb
nnoremap <leader>f :ALEFix<CR>
inoremap <C-l> <ESC>la
nmap <silent> cp :let @+ = expand("%")<cr> " copy relative path of current file"
nmap <silent> <leader>p cw<C-r>0<ESC> " paste word from current cursor with content in register 0
":command Cwd cd %:p:h " map Cwd to change directory to curret file
nnoremap <silent> vv <C-w>v " split vertically
nnoremap <leader>x :%!xxd<cr> " display in hex format
"nnoremap * *N " stay in current word when typing *
"https://superuser.com/questions/299646/vim-make-star-command-stay-on-current-word
"nmap <silent> * :let @/='\<'.expand('<cword>').'\>'<CR>
" Map alt-j, only workds in mac terminal, see https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
" Should use Meta mode for alt key in iTerm2
"execute "set <A-j>=^[j"
map <A-j> 5j
" Map alt-k
"execute "set <A-k>=^[k"
map <A-k> 5k
nnoremap <C-n> :vert term<cr>
nnoremap <Leader>e :e ~/.vimrc<cr>
nnoremap <Leader>r :so $MYVIMRC<cr> " reload vimrc of neovim
" move selected
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <silent> <leader>g  :Clap grep2<cr>
nnoremap <silent> <leader>f :Clap files<cr>
nnoremap <silent> <leader>G :Clap git_diff_files<cr>
nnoremap <silent> <leader>m :Clap marks<cr>
nnoremap <silent> <leader>j :Clap jumps<cr>
nnoremap <silent> <leader>b :Clap buffers<cr>

" For gitgutter
"nmap <leader>j <Plug>(GitGutterNextHunk)
"nmap <leader>k <Plug>(GitGutterPrevHunk)
"nmap <leader>hs <Plug>(GitGutterStageHunk)
"nmap <leader>hu <Plug>(GitGutterUndoHunk)
"nmap <leader>hp <Plug>(GitGutterPreviewHunk)
"
" For vim-sneak
" 2-character Sneak (default)
"nmap f <Plug>Sneak_s
"nmap F <Plug>Sneak_S
"" visual-mode
"xmap f <Plug>Sneak_s
"xmap F <Plug>Sneak_S
"map ; <Plug>Sneak_;
"map , <Plug>Sneak_,

" editors
syntax enable
set ignorecase
set smartcase " for case insensitive search
set foldmethod=syntax
set foldlevelstart=20
set spell spelllang=en_us
set encoding=utf-8
set number
set relativenumber
set colorcolumn=80
set clipboard=unnamed
set cino=l1,t0,g0,(0 " indent ( using =, cino controls the indentation
set mouse=n
"set mouse=a
set laststatus=2 " always turn on status line
set complete=.,w,b,i
set noswapfile

" tabs and spaces
set splitright
set hlsearch
set incsearch
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set cindent

" diff
set diffopt=vertical
au FileType python set cindent
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 indentexpr=GetGooglePythonIndent(v:lnum)
autocmd FileType yaml setlocal tabstop=4 shiftwidth=4 softtabstop=4 indentexpr=
autocmd FileType c setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab

" set theme
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termcolors=16
let python_highlight_all=1
" For lightline
set noshowmode

" must be put befor the colorscheme
" [ 'mode', 'paste' ],
let g:lightline = {
      \ 'active': {
      \   'left': [ ['gitbranch'], ['relativepath', 'modified'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ }
colorscheme solarized
set cursorline
" change current line color, should be put behind colorscheme
hi CursorLine gui=underline cterm=underline term=underline
" Change line number color
hi CursorLineNr ctermfg=DarkCyan ctermbg=Black
hi LineNr ctermfg=DarkGray ctermbg=Black
hi SignColumn ctermbg=DarkGrey ctermbg=Black


"Fix Shift+Tab
nmap <S-Tab> <<
imap <S-Tab> <Esc><<i
vnoremap <S-Tab> <<

" for ack
let g:ackhighlight = 1

" for NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['bazel-*[[dir]]', '\.o$', 'venv[[dir]]','dist[[dir]]', '\.egg-info$[[dir]]', '__pycache__[[dir]]', '\.su$']
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

" automatically remove trailing space on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" switch interpreter for jedi-vim, syntastic and YCM to adapt Python 3
" for jedi
let g:jedi#force_py_version = 3
let g:jedi#usages_command = "<leader>u"
let g:jedi#show_call_signatures = "1"

" for ale linter and fixing
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'python': ['pylint'],
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   'python': ['autopep8'],
\   'javascript': ['eslint'],
\}

" ignore files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,**/venv/**,*.pyc,*.pyo,__pycache__

" ignore files of ctrlp
let g:ctrlp_custom_ignore = '\v[\/]\(dist|__pycache__|build|venv)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|egg-info)$\venv$',
  \ 'file': '\v\.(exe|so|dll|o|pyc)$',
  \}
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " ignore files in .gitignore

" Indent Python in the Google way.
let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let g:pyindent_nested_paren='shiftwidth() * 1'
let g:pyindent_open_paren='shiftwidth() * 1'
let g:pyindent_continue = 'shiftwidth() * 1'

" Custom header guard
function! g:HeaderguardName()
  return "INC_" . toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g')) . "_"
endfunction

"autocmd VimEnter * if !argc() | NERDTree | endif

" For coc.nvim
source ~/.vim/coc_config.vimrc

" For vimwiki
" Use markdown syntax
"let g:vimwiki_list = [{'path': '~/vimwiki/',
                      "\ 'syntax': 'markdown', 'ext': '.md'}]

" For neovim
if !has('nvim')
    set ttymouse=xterm2
endif

" reduce vim delay
set updatetime=100
