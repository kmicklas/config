if exists("b:current_syntax")
  finish
endif

syn keyword alloyModule module open as
syn keyword alloySpecifier set lone some one seq
syn keyword alloySpecifier abstract all no sum disj let
syn keyword alloyDecl sig fact pred fun assert
syn keyword alloyConst none univ iden this
syn keyword alloyCommand run check for but exactly
syn keyword alloyOp not and or iff implies in extends else

syn match alloyOp '!'
syn match alloyOp '#'
syn match alloyOp '\~'
syn match alloyOp '\*'
syn match alloyOp '\^'
syn match alloyOp '&&'
syn match alloyOp '\|\|'
syn match alloyOp '<=>'
syn match alloyOp '=>'
syn match alloyOp '&'
syn match alloyOp '+'
syn match alloyOp '-'
syn match alloyOp '++'
syn match alloyOp '<:'
syn match alloyOp ':>'
syn match alloyOp '\.'
syn match alloyOp '='
syn match alloyOp '<'
syn match alloyOp '>'
syn match alloyOp '=<'
syn match alloyOp '>='

syn match alloyDelimeter '{'
syn match alloyDelimeter '}'
syn match alloyDelimeter '\['
syn match alloyDelimeter '\]'
syn match alloyDelimeter '('
syn match alloyDelimeter ')'
syn match alloyDelimeter '|'
syn match alloyDelimeter '@'
syn match alloyDelimeter '->'
syn match alloyDelimeter ':'
syn match alloyDelimeter '/'

syn match alloyLineComment '--.*$'
syn match alloyLineComment '//.*$'

syn region alloyComment start="/\*" end="\*/"

syn region alloyString start=/\v"/ skip=/\v\\./ end=/\v"/

syn match alloyNumber "[0-9]\+"

hi def link alloyComment Comment
hi def link alloyLineComment Comment
hi def link alloyNumber Number
hi def link alloyString String
hi def link alloyModule Label
hi def link alloySpecifier Type
hi def link alloyDecl Keyword
hi def link alloyConst Constant
hi def link alloyCommand Statement
hi def link alloyOp Operator
hi def link alloyDelimeter Delimeter
