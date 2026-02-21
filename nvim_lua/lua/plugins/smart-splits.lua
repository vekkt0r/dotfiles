return {
  'mrjones2014/smart-splits.nvim',
  opts = {
    ignored_buftypes = {
      'nofile',
      'quickfix',
      'prompt',
    },
    disable_multiplexer_nav_when_zoomed = true,
  },
  config = function(_, opts)
    require('smart-splits').setup(opts)
    vim.keymap.set('n', '<C-M-S-h>', require('smart-splits').resize_left)
    vim.keymap.set('n', '<C-M-S-j>', require('smart-splits').resize_down)
    vim.keymap.set('n', '<C-M-S-k>', require('smart-splits').resize_up)
    vim.keymap.set('n', '<C-M-S-l>', require('smart-splits').resize_right)
    -- moving between splits
    vim.keymap.set({ 'n', 't' }, '<C-M-h>', require('smart-splits').move_cursor_left)
    vim.keymap.set({ 'n', 't' }, '<C-M-j>', require('smart-splits').move_cursor_down)
    vim.keymap.set({ 'n', 't' }, '<C-M-k>', require('smart-splits').move_cursor_up)
    vim.keymap.set({ 'n', 't' }, '<C-M-l>', require('smart-splits').move_cursor_right)
    vim.keymap.set({ 'n', 't' }, '<C-M-\\>', require('smart-splits').move_cursor_previous)
    -- swapping buffers between windows
    -- vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
    -- vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
    -- vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
    -- vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
  end,
}
