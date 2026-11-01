return {
  'nvim-orgmode/orgmode',
  ft = { 'org' },
  opts = {
    org_todo_keywords = { 'TODO', 'ONGOING', '|', 'DONE' },
    org_adapt_indentation = false,
    org_blank_before_new_entry = {
      heading = false,
      plain_list_item = false,
    },
  },
}
