" Elm omni complete function
" 
" This complete function searches for matches in the following order:
" If at any point a match fails, it continues down the line
"   1. Module function
"     I. Check if prefixed by a module (check if imported)
"     II. followed by a dot
"     III. If module is 'core' module (elm or elm-community):
"       i. Use elm-packages to complete
"     IV. match base with exposed funcs in that module
"   2. Module
"     I. If base starts with a capital letter, do this
"     II. Match for module names imported or aliases
"   3. Constructors
"     I. If base starts with a capital letter, do thsi
"     II. Match for constructors sorted by proximity
"   4. Local keywords
"     I. Check for keywords defined locally (within function with type def)
"     II. Ordered by proximity to cursor location
"   5. Global top level keywords
"     I. Check for keywords globally imported
"   6. Global keywords
"     I. Check for all keywords
function CompleteVim(findstart, base)
  " echom "Called: |" . a:findstart . "| " . a:base . "|"
  if a:findstart
    " locate the start of the word
    " allows for a word that starts with [a-zA-Z_] and includes [a-zA-Z0-9_]
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\w'
      let start -= 1
    endwhile
    if start > 0 && line[start - 1] =~ '\h'
      let start -= 1
    endif
    return start
  else
    " find months matching with "a:base"
    for m in split("January February March April May June July August September October November December az9iner")
      if m =~ '^' . a:base
        call complete_add(m)
      endif
      " sleep 300m	" simulate searching for next match
      if complete_check()
        break
      endif
    endfor
    return []
  endif
endfunction

set omnifunc=CompleteVim
