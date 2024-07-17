if exists("b:current_syntax")
  finish
endif

syn case ignore

" Define keywords
syn keyword konKeyword fun return

" Define function arguments and return types
syn region konFunctionArgs start="(" end=")" transparent contains=konFunctionArg
syn keyword konFunctionArg int str

" Define function names
syn match konFunctionDecl /fun\s\+\w\+\ze\s*(/ transparent contains=konFunctionName
syn match konFunctionName /\w\+\ze\s*(/

" Define return names
syn match konReturnType /\w\+\ze\s*(/

" Define comments
syn match konComment "//.*$"

" Highlight numeric values
syn match konNumber /\d\+/

" Highlight operators
syn match konOperator /+/

" Set the default foreground color
hi def link konKeyword       Keyword
hi def link konFunctionArgs  Statement
hi def link konFunctionArg   Type
hi def link konFunctionName  Function
hi def link konReturnType    Type
hi def link konComment       Comment
hi def link konNumber        Number
hi def link konOperator      Operator

let b:current_syntax = "kon"

