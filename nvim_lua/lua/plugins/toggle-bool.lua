return {
  {
    'gerazov/toggle-bool.nvim',
    event = 'VeryLazy',
    opts = {
      mapping = '<leader>T',
      additional_toggles = {
        Yes = 'No',
        On = 'Off',
        ['0'] = '1',
        Enable = 'Disable',
        Enabled = 'Disabled',
      },
    },
  },
}
