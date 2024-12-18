return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = true }

    -- require('mini.completion').setup()
    require('mini.comment').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.bufremove').setup()

    local bufremove = require 'mini.bufremove'
    vim.keymap.set('n', ',d', bufremove.delete, { desc = 'Remove buffer' })

    local minifiles = require 'mini.files'
    minifiles.setup {}
    vim.keymap.set('n', '<leader>e', function()
      minifiles.open()
    end, { desc = 'File tree browser' })

    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    local spec_treesitter = require('mini.ai').gen_spec.treesitter
    require('mini.ai').setup {
      n_lines = 500,
      custom_textobjects = {
        F = spec_treesitter { a = '@function.outer', i = '@function.inner' },
        o = spec_treesitter {
          a = { '@conditional.outer', '@loop.outer' },
          i = { '@conditional.inner', '@loop.inner' },
        },
      },
    }
  end,
}
