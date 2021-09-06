" === puremourning/vimspector ===
let g:vimspector_enable_mappings = 'HUMAN'

" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

let s:jdt_ls_debugger_port = 0
function! s:StartDebugging()
  if s:jdt_ls_debugger_port <= 0
    " Get the DAP port
    let s:jdt_ls_debugger_port = youcompleteme#GetCommandResponse(
      \ 'ExecuteCommand',
      \ 'vscode.java.startDebugSession' )

    if s:jdt_ls_debugger_port == ''
       echom "Unable to get DAP port - is JDT.LS initialized?"
       let s:jdt_ls_debugger_port = 0
       return
     endif
  endif

  " Start debugging with the DAP port
  call vimspector#LaunchWithSettings( { 'DAPPort': s:jdt_ls_debugger_port } )
endfunction

nnoremap <silent> <Leader>da :call <SID>StartDebugging()<CR>

" Clears vimspector's breakpoints
nnoremap <silent> <Leader>cb :call vimspector#ClearBreakpoints()<CR>

" Vimspector reset layout
nnoremap <silent> <Leader>vr :VimspectorReset<CR>
" === puremourning/vimspector ===
