set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'davidhalter/jedi-vim' " for python autocomplete
Plugin 'w0rp/ale' " for python pep8
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter' " show git diff in sign column
Plugin 'tpope/vim-abolish' " case preserving replace
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround' " change surroundings
Plugin 'ctrlpvim/ctrlp.vim' " fuzzy file finder
Plugin 'tpope/vim-repeat' " optimize .
Plugin 'craigemery/vim-autotag' " auto update ctags
Plugin 'zxqfl/tabnine-vim'
Plugin 'drmikehenry/vim-headerguard' "add header guard

call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on
filetype indent on

" securities for custom .vimrc
set exrc
set secure

" find files in subfolders
set path+=**

" keymaps
let mapleader = " "
inoremap jj <ESC>
vnoremap . :norm.<CR>
map <leader>n :NERDTreeToggle<CR>
map <Leader> <Plug>(easymotion-prefix)
nmap <F8> :TagbarToggle<CR>
nmap <C-n> :vert ter<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap Q :w<CR>
nnoremap <C-S> :w<CR>
nnoremap X :bw<CR> " close and remove current buffer
nnoremap <F4> oimport ipdb<CR>ipdb.set_trace()<CR><ESC> " map F4 to insert ipdb
nnoremap <leader>f :ALEFix<CR>
map Q <ESC>
inoremap <C-l> <ESC>la
nmap cp :let @+ = expand("%")<cr> " copy relative path of current file"
nmap pb cw<C-r>0<ESC> " paste word from current cursor with content in register 0
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
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 indentexpr=GetGooglePythonIndent(v:lnum)
autocmd FileType yaml setlocal tabstop=4 shiftwidth=4 softtabstop=4 indentexpr=
autocmd FileType c setlocal tabstop=2 shiftwidth=2
autocmd FileType h setlocal tabstop=2 shiftwidth=2
autocmd FileType python setlocal formatprg=autopep8\ -
autocmd FileType md setlocal tabstop=3 shiftwidth=3
autocmd FileType markdown setlocal tabstop=3 shiftwidth=3


" set theme
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized
let python_highlight_all=1
hi StatusLine ctermfg=green ctermbg=2 cterm=None " change current window status line color
set cursorline
hi CursorLine ctermbg=LightBlue
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
let NERDTreeIgnore = ['\.o$', 'venv[[dir]]','dist[[dir]]', '\.egg-info$[[dir]]', '__pycache__[[dir]]']
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
"let g:jedi#popup_on_dot = 0
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
