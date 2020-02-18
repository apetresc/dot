"                   .                    
"  ##############..... ##############   
"  ##############......##############   
"    ##########..........##########     
"    ##########........##########       
"    ##########.......##########        
"    ##########.....##########..        
"    ##########....##########.....      
"  ..##########..##########.........    
"....##########.#########.............  
"  ..################JJJ............    
"    ################.............      
"    ##############.JJJ.JJJJJJJJJJ      
"    ############...JJ...JJ..JJ  JJ     
"    ##########.....JJ...JJ..JJ  JJ      
"    ########......JJJ..JJJ JJJ JJJ     
"    ######    .........                
"                .....                  
"                  .                    


" MISC {{{1
set nocompatible
syntax enable
filetype on
filetype plugin on

let mapleader=","
set noshowmode
set wrap
set number relativenumber
set nu rnu
set hidden
set exrc
set conceallevel=2
set colorcolumn=80

" Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>
" Shortcut to source (reload) THIS configuration file after editing it: (s)ource (c)onfiguraiton
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>
" Function to grab calendar info
function! GCal()
  let caloutput = system("gcalcli --nocolor --lineart unicode agenda --details all")

  " Open a new split and set it up
  vsplit __GCal_Agenda__
  normal! ggdG
  setlocal filetype=gcalcli
  setlocal buftype=nofile

  call append(0, split(caloutput, '\v\n'))
endfunction
command! GCal call GCal()

" live view of substitutions when typing out a replacement
set inccommand=nosplit

" PROVIDERS {{{1
set pyx=3
if filereadable(expand('~/.virtualenvs/pynvim/bin/python'))
  let g:python_host_prog = '~/.virtualenvs/pynvim/bin/python'
endif
if filereadable(expand('~/.virtualenvs/py3nvim/bin/python'))
  let g:python3_host_prog = '~/.virtualenvs/py3nvim/bin/python'
endif
if filereadable(expand('~/.nvm/versions/node/v12.14.1/bin/neovim-node-host'))
  let g:node_host_prog = expand('~/.nvm/versions/node/v12.14.1/bin/neovim-node-host')
endif


" PLUGINS {{{1
call plug#begin('~/.vim/plugged')
Plug 'jnurmine/zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'dylanaraps/wal.vim'
Plug '5long/pytest-vim-compiler'
Plug 'alfredodeza/pytest.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lervag/vimtex'
Plug 'fatih/vim-go'
Plug 'janko/vim-test'
Plug 'benmills/vimux'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/promptline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'chrisbra/Colorizer'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-unimpaired'
Plug 'liuchengxu/vista.vim'
Plug 'hashivim/vim-terraform'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/goyo.vim'
call plug#end()

" TMUX-NAVIGATOR {{{2
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" NERDTREE {{{2
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" let NERDTreeMapOpenInTab='<ENTER>'
nmap <C-\> :NERDTreeToggle<CR>
nmap <C-t> :NERDTreeFind<CR>

" VIMTEX {{{2
let g:vimtex_view_method = 'zathura'

" VIMUX {{{2
map <C-F10> :VimuxPromptCommand<CR>
map <F10> :VimuxRunLastCommand<CR>

" AIRLINE {{{2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" VIM-TEST {{{2
let test#strategy = "make"
let g:dispatch_compilers = {}
let g:dispatch_compilers['python'] = 'pytest'
nmap <silent> tf :TestFile<CR>
nmap <silent> tt :TestLast<CR>
nmap <silent> ta :TestSuite<CR>

" COC {{{2
if filereadable(expand('~/.nvm/versions/node/v12.14.1/bin/node'))
  let g:coc_node_path = expand('~/.nvm/versions/node/v12.14.1/bin/node')
  call coc#config('npm.binPath', expand('~/.nvm/versions/node/v12.14.1/bin/npm'))
endif

set cmdheight=2
set updatetime=300
set shortmess+=c

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

nnoremap <silent> <leader>s :<C-u>CocList outline<CR>
nnoremap <silent> <leader>w :<C-u>CocList --interactive symbols<CR>


" VISTA {{{2
let g:vista_icon_indent = ["▸ ", ""]
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1
let g:vista_echo_cursor_strategy = 'scroll'
nmap <C-s> :Vista!!<CR>

" GIT {{{2
let g:gitgutter_preview_win_floating = 0
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>gs :Gstatus<CR>

" MARKDOWN {{{2
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_extensions_in_markdown = 1

" VIM-GO {{{2
function! ReuseVimGoTerm(cmd) abort
    for w in nvim_list_wins()
        if "goterm" == nvim_buf_get_option(nvim_win_get_buf(w), 'filetype')
            call nvim_win_close(w, v:true)
            break
        endif
    endfor
    execute a:cmd
endfunction

let g:go_term_enabled = 1
let g:go_term_mode = "silent keepalt rightbelow 15 split"
let g:go_def_reuse_buffer = 1

autocmd FileType go nmap <leader>r :call ReuseVimGoTerm('GoRun')<Return>

" GOYO {{{2
nnoremap <silent> <leader>z :Goyo<CR>

" COLORS {{{1
set t_Co=256
if $COLOR_SCHEME_TYPE == "light"
  set background=light
endif
if !empty($COLOR_SCHEME)
  if $COLOR_SCHEME == "solarized"
    let g:solarized_termtrans=1
    colorscheme solarized
  elseif $COLOR_SCHEME == "zenburn"
    colorscheme zenburn
  elseif $COLOR_SCHEME == "pywal"
    colorscheme wal
  endif
endif

" FILETYPES {{{1
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown

" SPLITS {{{1
" Open splits to right and bottom, which feels more natural

set splitbelow
set splitright
nnoremap <C-W>- <C-W>s
nnoremap <C-W><BAR> <C-W>v

" WHITESPACE {{{1
set list
set listchars=tab:▸\ ,trail:·
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" CTRLP {{{1
nnoremap b :CtrlPBuffer<CR>

" TAGS {{{1
nnoremap <C-[> :pop<CR>
let g:ctrlp_extensions = ['tag']
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_switch_buffer = 'et'

" PERSISTENT UNDOS {{{1
" Keep undo history across sessions by storing it in a file
set undofile
set directory=$HOME/tmp/vim//
set backupdir=$HOME/tmp/vim//
set undodir=$HOME/tmp/vim//

" CLIPBOARD {{{1
set clipboard+=unnamedplus

" MOUSE {{{1
set mouse=a

" SEARCH {{{1
set ic


" }}}

" vim: ft=vim et sw=2: fdm=marker foldenable:
