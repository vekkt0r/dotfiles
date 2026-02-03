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
                  -- if
                  --   not utils.buffer_is_dirty(entry.bufnr, true, false)
                  --   or vim.api.nvim_buf_call(entry.bufnr, function()
                  --     return utils.save_dialog(entry.bufnr)
                  --   end)
                  -- then
                  bufremove.delete(entry.bufnr)
                  -- vim.api.nvim_buf_delete(entry.bufnr, { force = true })
                  -- end
                end
              end
            end,
            reload = true,
          },
        },
      },
    }
    require('fzf-lua').register_ui_select()
  end,
}
