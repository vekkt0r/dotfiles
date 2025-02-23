return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      sync_install = false,
      auto_install = true,
      modules = {},
      ignore_install = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            [']j'] = { query = '@cell.start', desc = 'Next cell start' },
          },
          goto_previous_start = {
            ['[j'] = { query = '@cell.start', desc = 'Prev cell start' },
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['ib'] = { query = '@cell.outer', desc = 'Jupytext cell' },
            ['if'] = { query = '@function.inner', desc = 'Inside function' },
            ['af'] = { query = '@function.outer', desc = 'Around function' },
            ['ip'] = { query = '@parameter.inner', desc = 'Inside parameter' },
            ['ap'] = { query = '@parameter.outer', desc = 'Around parameter' },
          },
        },
      },
    }
  end,
}
