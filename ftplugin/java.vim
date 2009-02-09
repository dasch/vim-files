
set softtabstop=4
set shiftwidth=4
set tabstop=4
set foldlevel=1
set expandtab smartindent

let java_highlight_all=0
let java_highlight_java_lang_ids=0
let java_highlight_java_lang=0
let java_highlight_functions="style"
let java_allow_cpp_keywords=1

" Javadoc comments (/** and */ pairs) and code sections (marked by {} pairs) mark the start and end of folds. All other
" lines simply take the fold level that is going so far.
function! MyFoldLevel( lineNumber )
  let thisLine = getline( a:lineNumber )
  " If the entire Javadoc comment or the {} pair is on one line, then don't create a fold for it.
  if ( thisLine =~ '\%(\%(/\*\*\).*\%(\*/\)\)\|\%({.*}\)' )
    return '='
  elseif ( thisLine =~ '\%(^\s*/\*\*\s*$\)\|{' )
    return "a1"
  elseif ( thisLine =~ '\%(^\s*\*/\s*$\)\|}' )
    return "s1"
  endif
  return '='
endfunction
setlocal foldexpr=MyFoldLevel(v:lnum)
setlocal foldmethod=expr

set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
set include=^#\s*import
set includeexpr=substitute(v:fname,'\\.','/','g')

