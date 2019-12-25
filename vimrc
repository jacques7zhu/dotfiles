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
Plug 'davidhalter/jedi-vim'
Plug 'w0rp/ale' " for python pep8
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter' " show git diff in sign column
Plug 'tpope/vim-abolish' " case preserving replace
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround' " change surroundings
Plug 'ctrlpvim/ctrlp.vim' " fuzzy file finder
Plug 'tpope/vim-repeat' " optimize .
Plug 'drmikehenry/vim-headerguard' "add header guard

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
map <leader>n :NERDTreeToggle<CR>
nmap <C-n> :vert ter<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap Y y$
nnoremap Q :w<CR>
nnoremap <C-S> :w<CR>
nnoremap X :bw<CR> " close and remove current buffer
nnoremap <F4> oimport ipdb<CR>ipdb.set_trace()<CR><ESC> " map F4 to insert ipdb
nnoremap <leader>f :ALEFix<CR>
inoremap <C-l> <ESC>la
nmap cp :let @+ = expand("%")<cr> " copy relative path of current file"
nmap <leader>p cw<C-r>0<ESC> " paste word from current cursor with content in register 0
:command Cwd cd %:p:h " map Cwd to change directory to curret file

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
autocmd FileType c setlocal tabstop=2 shiftwidth=2
autocmd FileType h setlocal tabstop=2 shiftwidth=2
autocmd FileType md setlocal tabstop=3 shiftwidth=3
autocmd FileType markdown setlocal tabstop=2 shiftwidth=2


" set theme
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termcolors=16
let python_highlight_all=1
colorscheme solarized
set cursorline
hi CursorLine gui=underline cterm=underline term=underline
" change current line color, should be put behind colorscheme

"Fix Shift+Tab
nmap <S-Tab> <<
imap <S-Tab> <Esc><<i
vnoremap <S-Tab> <<

" for ack
let g:ackhighlight = 1

" for NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['\.o$', 'venv[[dir]]','dist[[dir]]', '\.egg-info$[[dir]]', '__pycache__[[dir]]', '\.su$']
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
\}
let g:ale_fixers = {
\   'python': ['autopep8'],
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

autocmd VimEnter * if !argc() | NERDTree | endif
