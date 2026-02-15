return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    local statusline = require 'mini.statusline'
    statusline.setup {
      use_icons = true,
      content = {
        active = function()
          local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
          local git = statusline.section_git { trunc_width = 75 }
          local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
          local filename = statusline.section_filename { trunc_width = 140 }
          local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
          local location = statusline.section_location { trunc_width = 75 }
          local search = statusline.section_searchcount { trunc_width = 75 }

          local actual_mode_hl = vim.bo.modified and 'MiniStatuslineModeModified' or mode_hl

          return statusline.combine_groups {
            { hl = actual_mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = 'MiniStatuslineLocation', strings = { location } },
            { hl = 'MiniStatuslineSearch', strings = { search } },
          }
        end,
      },
    }

    vim.api.nvim_set_hl(0, 'MiniStatuslineModeModified', {
      fg = '#000000',
      bg = '#ffcc00',
      bold = true,
    })

    -- require('mini.completion').setup()
    require('mini.comment').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup {
      custom_surroundings = {
        ['{'] = {
          input = { '%b{}' },
          output = { left = '{\n', right = '\n}' },
        },
      },
    }
    require('mini.bufremove').setup()

    local bufremove = require 'mini.bufremove'
    vim.keymap.set('n', '<leader>x', bufremove.delete, { desc = 'Remove buffer' })

    local trailspace = require 'mini.trailspace'
    trailspace.setup {}
    vim.keymap.set('n', '<leader>w', trailspace.trim)

    local minifiles = require 'mini.files'
    minifiles.setup {}
    vim.keymap.set('n', '<leader>e', function()
      minifiles.open(vim.api.nvim_buf_get_name(0))
    end, { desc = 'File tree browser' })

    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    local spec_treesitter = require('mini.ai').gen_spec.treesitter
    require('mini.ai').setup {
      n_lines = 500,
      custom_textobjects = {
        f = spec_treesitter { a = '@function.outer', i = '@function.inner' },
        c = spec_treesitter { a = '@class.outer', i = '@class.inner' },
        o = spec_treesitter {
          a = { '@conditional.outer', '@loop.outer' },
          i = { '@conditional.inner', '@loop.inner' },
        },
      },
    }
  end,
}
