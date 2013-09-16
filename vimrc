noremap ; :
noremap <Space> i
noremap <CR> i
noremap j h
noremap i k
noremap k j
imap <S-Space> <Esc>
imap <C-Space> <Esc>

colorscheme desert
syntax on
set hlsearch
set mouse=a
set nobackup
set noswapfile
set number
set tabstop=4
set smartcase
set autoindent
set copyindent

au BufEnter *.arr set syntax=pyret
