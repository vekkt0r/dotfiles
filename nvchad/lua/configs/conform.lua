local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "autopep8" },
    cpp = { "clang-format" },
    c = { "clang-format" },
  },

  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "python" then
      return
    end
    -- These options will be passed to conform.format()
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}

return options
