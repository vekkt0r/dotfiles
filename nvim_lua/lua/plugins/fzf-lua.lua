return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- local actions = require 'fzf-lua.actions'
    local path = require 'fzf-lua.path'
    local utils = require 'fzf-lua.utils'
    local bufremove = require 'mini.bufremove'
    require('fzf-lua').setup {
      buffers = {
        actions = {
          ['ctrl-k'] = {
            fn = function(selected, opts)
              for _, sel in ipairs(selected) do
                local entry = path.entry_to_file(sel, opts)
                if entry.bufnr then
                  bufremove.delete(entry.bufnr)
                end
              end
            end,
            reload = true,
          },
        },
      },
      keymap = {
        builtin = {
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up',
        },
      },
    }
    require('fzf-lua').register_ui_select()
  end,
}
