" Check for and install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install new plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
 \|   PlugInstall --sync | q
 \| endif


" Load plugins >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
call plug#begin('~/.vim/plugged')

" Sensible defaults
Plug 'tpope/vim-sensible'

" Git helper commands 
Plug 'tpope/vim-fugitive'

" Surround [] () '' 
Plug 'tpope/vim-surround'

" Comment out with gcc 
Plug 'tpope/vim-commentary'

" UI
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Explorer
Plug 'preservim/nerdtree'

" Vim to tmux navigator
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Load plugins

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Enable copy paste to system clipboard
set clipboard=unnamedplus

" NERDTree
" Start NERDTree if starting vim with no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

" coc completion settings
source ~/.coc.vim

" Show line numbers
set nu

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Visual mode pressing * or # searches for the current selection
" " Super useful! From an idea by Michael Naumann
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Color palette
set termguicolors
set background=dark
colorscheme gruvbox
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
