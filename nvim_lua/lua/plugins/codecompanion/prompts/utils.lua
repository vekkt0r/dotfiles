return {
  git_diff = function(_)
    return vim.system({ 'git', 'diff', '--no-ext-diff' }, { text = true }):wait().stdout
  end,
}
