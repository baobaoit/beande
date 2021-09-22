" ╔═════════════════════════════════╗
" ║ Settings for dense-analysis/ale ║
" ╚═════════════════════════════════╝
let b:ale_fixers = ['google_java_format', 'remove_trailing_lines', 'trim_whitespace']
let b:ale_linters = ['checkstyle', 'eclipselsp', 'javac']
let g:ale_java_eclipselsp_path = $JDTLS_HOME
let g:ale_java_checkstyle_config = $HOME.'/.config/nvim/rule/google_checks.xml'

" ╔═════════════════════╗
" ║ Settings for JDT.LS ║
" ╚═════════════════════╝
set wildignore+=*/node_modules/*
set wildignore+=*/target/*
set wildignore+=*/.mvn/*
set wildignore+=*/.metadata/*
set wildignore+=*/.settings/*
set wildignore+=*/.idea/*
set wildignore+=*/.vscode/*
set wildignore+=*/out/*
