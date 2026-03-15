return {
  dir = vim.fn.stdpath 'config' .. '/lua/plugins/wezterm-move.nvim',
  -- event = 'VeryLazy',
  dependencies = {
    'ibhagwan/fzf-lua',
  },
  keys = {
    {
      '<C-w>',
    },
    {
      '<C-M-h>',
      function()
        require('wezterm-move').move 'h'
      end,
      mode = { 'n', 't' },
    },
    {
      '<C-M-j>',
      function()
        require('wezterm-move').move 'j'
      end,
      mode = { 'n', 't' },
    },
    {
      '<C-M-k>',
      function()
        require('wezterm-move').move 'k'
      end,
      mode = { 'n', 't' },
    },
    {
      '<C-M-l>',
      function()
        require('wezterm-move').move 'l'
      end,
      mode = { 'n', 't' },
    },
  },
  config = function()
    -- Workaround to be able to detect if vim when using wezterm mux
    local base64 = require 'fzf-lua.lib.base64'
    local function wezterm_set_is_nvim(val)
      local success = false
      local file = io.open('/dev/fd/2', 'wb')
      local encoded = base64.encode(val)
      local var = string.format('\027]1337;SetUserVar=IS_NVIM=%s\007', encoded)

      if file then
        success = file:write(var) ~= nil
        file:close()
      else
        success = vim.api.nvim_chan_send(vim.v.stderr, var) > 0
      end

      return success
    end

    wezterm_set_is_nvim 'true'
    vim.api.nvim_create_autocmd('VimResume', {
      callback = function()
        wezterm_set_is_nvim 'true'
      end,
    })
    vim.api.nvim_create_autocmd({ 'VimSuspend', 'VimLeavePre' }, {
      callback = function()
        wezterm_set_is_nvim 'false'
      end,
    })
  end,
}
