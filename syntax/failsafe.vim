" Vim syntax file
" Language:     FailSafe
" Filenames:    *.fs
" Maintainers:  Daniel Schierbeck <daniel.schierbeck@gmail.com>
" Last Change:  2008 Jan 11 - Implemented initial version

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" SML is case sensitive.
syn case match

" lowercase identifier - the standard way to match
syn match    fsLCIdentifier /\<\(\l\|_\)\(\w\|'\)*\>/

syn match    fsKeyChar    "|"

" " Errors
" syn match    fsBraceErr   "}"
" syn match    fsBrackErr   "\]"
syn match    fsParenErr   ")"
" syn match    fsCommentErr "\*)"
" syn match    fsThenErr    "\<then\>"

" Some convenient clusters
" syn cluster  fsAllErrs contains=fsBraceErr,fsBrackErr,fsParenErr,fsCommentErr,fsEndErr,fsThenErr
syn cluster  fsAllErrs contains=fsParenErr

" syn cluster  fsAENoParen contains=fsBraceErr,fsBrackErr,fsCommentErr,fsEndErr,fsThenErr

syn cluster  fsContained contains=fsTodo,fsPreDef,fsModParam,fsModParam1,fsPreMPRestr,fsMPRestr,fsMPRestr1,fsMPRestr2,fsMPRestr3,fsModRHS,fsFuncWith,fsFuncStruct,fsModTypeRestr,fsModTRWith,fsWith,fsWithRest,fsModType,fsFullMod


" Enclosing delimiters
syn region   fsEncl transparent matchgroup=fsKeyword start="(" matchgroup=fsKeyword end=")" contains=ALLBUT,@fsContained,fsParenErr


" Comments
syn region   fsComment start="(\*" end="\*)" contains=fsComment,fsTodo
syn keyword  fsTodo contained TODO FIXME XXX


" loop
syn region   fsEnd matchgroup=fsKeyword start="\<loop\>" matchgroup=fsKeyword end="\<end\>" contains=ALLBUT,@fsContained,fsEndErr

syn keyword  fsKeyword  loop get maybe read write

syn keyword  fsType     int

syn match    fsConstructor  "(\s*)"
syn match    fsConstructor  "\u\(\w\|'\)*\>"

" Module prefix
syn match    fsModPath      "\u\(\w\|'\)*\."he=e-1

syn match    fsCharacter    +#"\\""\|#"."\|#"\\\d\d\d"+
syn match    fsCharErr      +#"\\\d\d"\|#"\\\d"+
syn region   fsString       start=+"+ skip=+\\\\\|\\"+ end=+"+

syn match    fsFunDef       "->"
syn match    fsRefAssign    ":="
syn match    fsRefAssign    "=:"
syn match    fsKeyChar      ";"
syn match    fsKeyChar      "\*"
syn match    fsKeyChar      "="

syn match    fsNumber        "\<-\=\d\+\>"
syn match    fsNumber        "\<-\=0[x|X]\x\+\>"

" Synchronization
syn sync minlines=20
syn sync maxlines=500

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_fs_syntax_inits")
  if version < 508
    let did_fs_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink fsParenErr     Error

  HiLink fsModPath      Include
  HiLink fsModule       Include
  HiLink fsModParam1    Include
  HiLink fsModType      Include
  HiLink fsMPRestr3     Include
  HiLink fsFullMod      Include
  HiLink fsModTypeRestr Include
  HiLink fsWith         Include
  HiLink fsMTDef        Include

  HiLink fsConstructor  Constant

  HiLink fsModPreRHS    Keyword
  HiLink fsMPRestr2     Keyword
  HiLink fsKeyword      Keyword
  HiLink fsFunDef       Keyword
  HiLink fsRefAssign    Keyword
  HiLink fsKeyChar      Keyword
  HiLink fsAnyVar       Keyword
  HiLink fsTopStop      Keyword
  HiLink fsOperator     Keyword

  HiLink fsBoolean      Boolean
  HiLink fsCharacter    Character
  HiLink fsNumber       Number
  HiLink fsReal         Float
  HiLink fsString       String
  HiLink fsType         Type
  HiLink fsTodo         Todo
  HiLink fsEncl         Keyword

  delcommand HiLink
endif

let b:current_syntax = "fs"

" vim: ts=8
