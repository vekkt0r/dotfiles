return {
  'craftzdog/solarized-osaka.nvim',
  lazy = false,
  config = function()
    require('solarized-osaka').setup {
      on_colors = function(colors)
        colors.bg_float = '#00242d'
      end,
    }
    vim.cmd 'colorscheme solarized-osaka'
  end,
}
