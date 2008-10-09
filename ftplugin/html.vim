
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab smartindent


nnoremap \hc :call InsertCloseTag()<CR>
imap <F8> <Space><BS><Esc>\hca
function! InsertCloseTag()
" inserts the appropriate closing HTML tag; used for the \hc operation defined
" above;
" requires ignorecase to be set, or to type HTML tags in exactly the same case
" that I do;
" doesn't treat <P> as something that needs closing;
" clobbers register z and mark z
" 
" by Smylers  http://www.stripey.com/vim/
" 2000 May 3

  if &filetype == 'html' || &filetype == 'xhtml'
  
    " list of tags which shouldn't be closed:
    let UnaryTags = ' Area Base Br DD DT HR Img Input LI Link Meta P Param '

    " remember current position:
    normal mz

    " loop backwards looking for tags:
    let Found = 0
    while Found == 0
      " find the previous <, then go forwards one character and grab the first
      " character plus the entire word:
      execute "normal ?\<LT>\<CR>l"
      normal "zyl
      let Tag = expand('<cword>')

      " if this is a closing tag, skip back to its matching opening tag:
      if @z == '/'
        execute "normal ?\<LT>" . Tag . "\<CR>"

      " otherwise this is the tag that needs closing:
      else
        let Found = 1

      endif
    endwhile " not yet found match

    " create the closing tag and insert it:
    let @z = '</' . Tag . '>'
    normal `z"zp

  else " filetype is not HTML
    echohl ErrorMsg
    echo 'The InsertCloseTag() function is only intended to be used in HTML ' .
      \ 'files.'
    sleep
    echohl None
  
  endif " check on filetype

endfunction " InsertCloseTag()

" Wraps visual selection in an HTML tag
vmap ,w <ESC>:call VisualHTMLTagWrap()<CR>

function! VisualHTMLTagWrap()
    let a:tag = input( "Tag to wrap block: ")
    let a:jumpright = 2 + len( a:tag )
    normal `<
    let a:init_line = line( "." )
    exe "normal i<".a:tag.">"
    normal `>
    let a:end_line = line( "." )
    " Don't jump if we're on a new line
    if( a:init_line == a:end_line )
" Jump right to compensate for the characters we've added
exe "normal ".a:jumpright."l"
    endif
    exe "normal a</".a:tag.">"
endfunction 
