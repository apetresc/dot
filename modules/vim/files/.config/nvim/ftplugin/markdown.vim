" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal textwidth=80
setlocal colorcolumn=80
setlocal formatoptions+=tcqln
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+
setlocal nofoldenable
setlocal spell spelllang=en_us

function! PreviewMarkdown()
  :! pandoc % | qutebrowser-pipe
endfunction

nnoremap <buffer> <leader>v :call PreviewMarkdown()<cr>

