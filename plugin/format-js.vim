if (exists('formatjs_loaded') || &cp)
  finish
endif

let formatjs_loaded = 1

function! s:FormatJS()
  " store current cursor position and change the working directory
  let win_view = winsaveview()
  " make sure both row and col are 0 based
  let row = -1 + win_view.lnum
  let file_wd = expand('%:p:h')
  let current_wd = getcwd()
  execute ':lcd' . file_wd

  " pass whole buffer content to esformatter
  let output = system('formatjs --row ' . row . ' --col ' . win_view.col, join(getline(1,'$'), "\n"))

  if v:shell_error
    echom "Error while executing formatjs! no changes made."
    echo output
  else
    " delete whole buffer content and append the formatted code
    normal! ggdG
    let source = split(output, "\n")
    " get the cursor and make an array
    let new_cursor = split(remove(source, 0))
    " convert 0 based to 1 based
    let new_row = new_cursor[0] + 1
    let new_col = new_cursor[1] + 1
    call append(0, source)
    " need to delete the last line since append() will add an extra line
    execute ':$d'
  endif

  " Clean up: restore previous cursor position and working directory
  call winrestview(win_view)
  call cursor(new_row, new_col)
  execute ':lcd' . current_wd
endfunction


command! -range=0 -complete=shellcmd Formatjs call s:FormatJS()
