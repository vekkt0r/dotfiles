return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'r', 'query', 'vim', 'vimdoc', 'yaml' },
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
            ['aj'] = { query = '@cell.outer', desc = 'Select cell' },
            ['ij'] = { query = '@cellcontent', desc = 'Select cell contents' },
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
