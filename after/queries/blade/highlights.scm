; (directive) @function
; (directive_start) @function
; (directive_end) @function
; (comment) @comment
((parameter) @include (#set! "priority" 110))
((php_only) @include (#set! "priority" 110))
; ((bracket_start) @function (#set! "priority" 120))
; ((bracket_end) @function (#set! "priority" 120))
(keyword) @function

(directive) @tag
(directive_start) @tag
(directive_end) @tag
(bracket_start) @tag.delimiter
(bracket_end) @tag.delimiter
(comment) @comment @spell
