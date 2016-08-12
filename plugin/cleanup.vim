let s:whitespace_regexes = [
  \ '\s+$',
  \ '\S\s\zs\s+\ze\S',
  \ '\[\zs\s+\ze',
  \ '\zs\s+\ze\]'
  \ ]

let s:full_whitespace_regex = ''

let iter = 0
while iter < len(s:whitespace_regexes)
  if iter > 0
    let s:full_whitespace_regex .= '|'
  endif

  let s:full_whitespace_regex .= '(' . get(s:whitespace_regexes, iter). ')'
  let iter += 1
endwhile

function s:CleanupRegex(regex)
  execute "normal mq"

  execute 'g/\v' . a:regex . '/s'

  execute "normal `q"
endfunction

function! CleanupUnwantedWhitespace()
  call s:CleanupRegex(s:full_whitespace_regex)
endfunction

" highlight CleanupExtraWhitespace ctermbg=red
" execute 'match CleanupExtraWhitespace /\v' . s:full_whitespace_regex .'/'
