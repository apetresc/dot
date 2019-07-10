set nocompatible
syntax enable
filetype plugin on

" ************************ PLUGINS ********************************************
call plug#begin('~/.vim/plugged')
Plug 'jnurmine/zenburn'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lervag/vimtex'
Plug 'fatih/vim-go'
Plug 'janko/vim-test'
Plug 'benmills/vimux'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" ************************ COLORS *********************************************
set t_Co=256
color zenburn
set termguicolors
set colorcolumn=100

" ************************ TMUX-NAVIGATOR *************************************
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" ************************ NERDTREE *******************************************
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" let NERDTreeMapOpenInTab='<ENTER>'
nmap <C-\> :NERDTreeToggle<CR>
nmap <C-t> :NERDTreeFind<CR>

" ************************ VIMTEX *********************************************
let g:vimtex_view_method = 'zathura'

" ************************ SPLITS *********************************************
" Open splits to right and bottom, which feels more natural
set splitbelow
set splitright

" ************************* WHITESPACE ****************************************
set list
set listchars=tab:▸\ ,trail:·
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" ************************* TAGS **********************************************
nnoremap <C-[> :pop<CR>
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = '.*.pyc'
let g:ctrlp_switch_buffer = 'et'

" ************************* PERSISTENT UNDOS **********************************
" Keep undo history across sessions by storing it in a file
set undofile
set directory=$HOME/tmp/vim//
set backupdir=$HOME/tmp/vim//
set undodir=$HOME/tmp/vim//
" ************************* CLIPBOARD *****************************************
set clipboard+=unnamedplus

" ************************* MOUSE *********************************************
set mouse=a

" ************************* SEARCH ********************************************
set ic

" ************************* VIMUX *********************************************
map <C-F10> :VimuxPromptCommand<CR>
map <F10> :VimuxRunLastCommand<CR>

" ************************* MISC **********************************************
let mapleader=","
set noshowmode
set wrap
set number
set hidden

" live view of substitutions when typing out a replacement
set inccommand=nosplit

" Make "Y" copy from cursor to end of line, instead of the whole line
map Y y$

" *************************** AIRLINE *****************************************
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" *************************** VIM-TEST ****************************************
let test#strategy = "vimux"
nmap <silent> tf :TestFile<CR>
nmap <silent> tt :TestLast<CR>

" **************************** COC ********************************************
set cmdheight=2
set updatetime=300
set shortmess+=c
nmap <silent> <C-[> <Plug>(coc-definition)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
