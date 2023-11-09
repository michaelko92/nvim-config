call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'morhetz/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'neoclide/coc.nvim'
Plug 'tpope/vim-fugitive'
call plug#end()


colorscheme gruvbox

set number            " Show line numbers
set relativenumber    " Show relative line numbers
set nowrap            " Don't auto-wrap text
call plug#end()


colorscheme gruvbox

set number            " Show line numbers
set relativenumber    " Show relative line numbers
set nowrap            " Don't auto-wrap text
set mouse=a           " Enable mouse support
set clipboard=unnamedplus  " Use system clipboard
set splitright        " Vertical splits to the right
set splitbelow        " Horizontal splits below
set hidden            " Enable switching buffers without saving
set background=dark  " or 'light' for light mode

let mapleader = " "
nnoremap <leader>n :NERDTreeToggle<CR>   " Toggle NERDTree with <leader>n
nnoremap <M-Left> <C-w>h
nnoremap <A-Down> <C-w>j
nnoremap <A-Up> <C-w>k
nnoremap <A-Right> <C-w>l

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

nnoremap <leader>fc <cmd>Telescope git_commits<CR>
nnoremap <leader>fb <cmd>Telescope git_bcommits<CR>
nnoremap <leader>fs <cmd>Telescope git_status<CR>
nnoremap <leader>ft <cmd>Telescope git_stash<CR>

nnoremap <leader>fo <cmd>Telescope oldfiles<CR>
nnoremap <leader>fr <cmd>Telescope registers<CR>


let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ ]
