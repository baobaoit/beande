" === joshdick/onedark.vim ===
syntax on
colorscheme onedark
if (has("autocmd"))
  augroup colorextend
  	autocmd ColorScheme * call onedark#extend_highlight("Comment", { "fg": { "gui": "#728083" } })
  	autocmd ColorScheme * call onedark#extend_highlight("LineNr", { "fg": { "gui": "#728083" } })
  augroup END
endif
" === joshdick/onedark.vim ===
