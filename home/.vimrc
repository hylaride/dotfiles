filetype off

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'airblade/vim-gitgutter'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
call plug#end()

set encoding=utf8
set laststatus=2     " Necessary for vim-airline
set background=dark " or light if you prefer the light version
syntax enable

" base16 colours
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set number
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt-=preview
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

let g:airline_theme='base16'
let g:airline_powerline_fonts = 1

" Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Terraform
let g:syntastic_terraform_tffilter_plan = 1
let g:terraform_completion_keys = 1
let g:terraform_registry_module_completion = 0
let g:terraform_fmt_on_save = 1

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
set ts=2 sw=2 et
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

" NertTree
map <C-t> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
