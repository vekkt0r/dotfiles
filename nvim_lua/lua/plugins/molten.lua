return {
  {
    'vekkt0r/molten-nvim',
    build = ':UpdateRemotePlugins',
    ft = { 'markdown', 'python' },
    dependencies = {
      { 'GCBallesteros/jupytext.nvim' },
      {
        'folke/snacks.nvim',
        ---@type snacks.Config
        opts = {
          image = {},
        },
      },
    },
    init = function()
      vim.g.molten_image_provider = 'snacks.nvim'
      vim.g.molten_output_show_exec_time = false
    end,
  },
}
