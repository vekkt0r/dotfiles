; extends
(module
  (comment) @cell.start
  (#eq? @cell.start "# %%")
  .
  [
    (import_statement)* @cell.content
    (expression_statement)* @cell.content
    (function_definition)* @cell.content
    (class_definition)* @cell.content
    (if_statement)* @cell.content
    (for_statement)* @cell.content
    (while_statement)* @cell.content
    (comment)* @cell.content
  ]
  .
  (comment)? @cell.end
  (#eq? @cell.end "# %%")
  (#make-range! "cell.outer" @cell.start @cell.content)
)
