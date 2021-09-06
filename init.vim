let nvim_config_dir = '~/.config/nvim/'

" Plug-in
call plug#begin('~/.config/nvim/plugged')

" {{ Theme }}
  Plug 'joshdick/onedark.vim'

" {{ Status bar }}
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

" {{ File browser }}
  Plug 'preservim/nerdTree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" {{ File search }}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'jremmen/vim-ripgrep'

" {{ Code syntax highlight }}
  Plug 'uiiaoo/java-syntax.vim'
  Plug 'sheerun/vim-polyglot'

" {{ Code intellisense }}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ycm-core/YouCompleteMe'

" {{ Auto pair }}
  Plug 'jiangmiao/auto-pairs'

" {{ Terminal }}
  Plug 'voldikss/vim-floaterm'

" {{ Git }}
  Plug 'tpope/vim-fugitive'

" {{ Debug }}
  Plug 'puremourning/vimspector'

" {{ 80 characters limit }}
  Plug 'whatyouhide/vim-lengthmatters'

" {{ Remove unused imports }}
  Plug 'akhaku/vim-java-unused-imports'

call plug#end()

set mouse=a
set tabstop=4
set shiftwidth=4
set number
set ignorecase
set listchars=tab:\|\ 
set list
set foldmethod=indent
set foldlevelstart=99
set path+=**

" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Auto reload content changed outside
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Search a hightlighted text
" vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Close current file opened without closing the window.
nnoremap <silent> <leader>bd :bp\|bd #<CR>

let nvim_settings_dir = nvim_config_dir.'settings/'

execute 'source '.nvim_settings_dir.'onedark.vim'
execute 'source '.nvim_settings_dir.'vim-airline.vim'
execute 'source '.nvim_settings_dir.'nerdTree.vim'
execute 'source '.nvim_settings_dir.'fzf.vim'
execute 'source '.nvim_settings_dir.'vim-polyglot.vim'
execute 'source '.nvim_settings_dir.'coc-vimlsp.vim'
execute 'source '.nvim_settings_dir.'coc.vim'
execute 'source '.nvim_settings_dir.'vim-floaterm.vim'
execute 'source '.nvim_settings_dir.'vim-devicons.vim'
execute 'source '.nvim_settings_dir.'YouCompleteMe.vim'
execute 'source '.nvim_settings_dir.'vimspector.vim'
execute 'source '.nvim_settings_dir.'vim-lengthmatters.vim'
execute 'source '.nvim_settings_dir.'vim-java-unused-imports.vim'

let nvim_scripts_dir = nvim_config_dir.'scripts/'

execute 'source '.nvim_scripts_dir.'java-vimspector-json.vim'
