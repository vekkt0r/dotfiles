return {
  {
    'alexghergh/nvim-tmux-navigation',
    --event = 'User FilePost',
    config = function()
      require('nvim-tmux-navigation').setup {
        keybindings = {
          left = '<C-M-h>',
          down = '<C-M-j>',
          up = '<C-M-k>',
          right = '<C-M-l>',
          last_active = '<C-\\>',
        },
      }
    end,
  },
}
