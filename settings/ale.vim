" === dense-analysis/ale ===
let g:ale_disable_lsp = 1

let g:ale_linters = {
\   'java': ['checkstyle'],
\}

let g:ale_fixers = {
\   'java': ['google_java_format'],
\}

let g:ale_sign_column_always = 1

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" Navigate between errors quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Run linters only when I save files
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

" Use the quickfix list instead of the loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
" === dense-analysis/ale ===
