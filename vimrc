noremap ; :
noremap <Space> i
noremap <CR> i
noremap j h
noremap i k
noremap k j
imap <S-Space> <Esc>
imap <C-Space> <Esc>

colorscheme evening
syntax on
set hlsearch
set mouse=a
set nobackup
set noswapfile
set number
set tabstop=4
set shiftwidth=4
set smartcase
set autoindent
set copyindent
set virtualedit=onemore

au BufEnter *.arr set syntax=pyret
au BufEnter *.arr set shiftwidth=2
au BufEnter *.arr set softtabstop=2
au BufEnter *.arr set expandtab
