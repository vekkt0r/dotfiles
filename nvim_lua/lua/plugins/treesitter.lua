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
      },
      incremental_selection = {
        enable = true,
        init_selection = 'gnn',
        node_inremental = 'grn',
        scope_incremental = 'grc',
        node_decremental = 'grm',
      },
      textobjects = {
        select = {
          enable = true,
        },
        move = {
          enable = true,
          goto_next_start = {
            [']j'] = { query = '@cell.start', desc = 'Next cell start' },
          },
          goto_previous_start = {
            ['[j'] = { query = '@cell.start', desc = 'Prev cell start' },
          },
        },
      },
    }
  end,
}
