return {
  'lewis6991/gitsigns.nvim',
  --event = 'User FilePost',
  opts = {
    signs = {
      delete = { text = '󰍵' },
      changedelete = { text = '󱕖' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- next hunk
      map('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gitsigns.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      -- previous hunk
      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gitsigns.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })
    end,
  },
}
