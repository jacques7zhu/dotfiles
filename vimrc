set nocompatible              " be iMproved, required
filetype off                  " required

" Load Vimtex
let &rtp  = '~/.vim/bundle/vimtex,' . &rtp
let &rtp .= ',~/.vim/bundle/vimtex/after'

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'valloric/youcompleteme'
Plugin 'davidhalter/jedi-vim' " for python autocomplete
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'c.vim'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'craigemery/vim-autotag'
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'airblade/vim-gitgutter' " show git diff in sign column

call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on

" securities for custom .vimrc
set exrc
set secure

" find files in subfolders
set path+=**

" keymaps
"let mapleader = "\<Space>"
let mapleader = " "
inoremap jj <ESC>
vnoremap . :norm.<CR>
map <leader>n :NERDTree<CR>
map <Leader> <Plug>(easymotion-prefix)
nmap <F8> :TagbarToggle<CR>
"let maplocalleader = ","

" editors
syntax enable
set mouse=a
set ignorecase
set smartcase " for case insensitive search
set foldmethod=syntax
set foldlevelstart=20
set spell spelllang=en_us
set encoding=utf-8
set number
set colorcolumn=80
set clipboard=unnamed
set cino+=(0 " indent ( using =
:set cinoptions=:0,l1,t0,g0,(0

" tabs and spaces
filetype plugin indent on
set tabstop=2
set expandtab
set shiftwidth=2
set splitright
"set hlsearch
set incsearch

" set theme
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized

" for YCM C/C++ autocomplete
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" for ack
let g:ackhighlight = 1

" for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_loc_list_height=5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_check_header = 1
let g:syntastic_c_include_dirs = [ 'include', 'inc', '../inc', '../../inc']
let g:syntastic_cpp_compiler = 'gcc'

" for NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['\.o$', 'build/$']

" for airline
let g:airline_theme = 'solarized'

" for easy-motion
map <Leader>/ <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"nmap s <Plug>(easymotion-overwin-f2)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" for ultisnips
" for solving the <tab> collision with ycm
let g:ycm_key_list_select_completion=["<tab>"]
let g:ycm_key_list_previous_completion=["<S-tab>"]

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsExpandTrigger="<nop>"
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"

let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories=["mysnippets", "UltiSnips"]

" automatically remove trailing space on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" switch interpreter for jedi-vim, syntastic and YCM to adapt Python 3
let g:jedi#force_py_version = 3
let g:syntastic_python_python_exec = 'python3'
let g:ycm_server_python_interpreter = 'python3'
let g:jedi#popup_on_dot = 0
