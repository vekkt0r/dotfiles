return {
  'craftzdog/solarized-osaka.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('solarized-osaka').setup {
      ---@param hl table
      ---@param c table
      on_highlights = function(hl, c)
        hl.WinSeparator = {
          fg = c.TabLineSel,
        }
        hl.FzfLuaBorder = {
          fg = c.yellow700,
          bg = c.base03,
        }
        hl.BlinkCmpMenu = {
          bg = c.base03,
        }
        hl.BlinkCmpMenuBorder = {
          fg = c.yellow700,
          bg = c.base03,
        }
        hl.BlinkCmpSignatureHelpBorder = hl.BlinkCmpMenuBorder
      end,
      on_colors = function(colors)
        colors.bg_float = colors.base03
      end,
    }
    vim.cmd 'colorscheme solarized-osaka'
  end,
}
