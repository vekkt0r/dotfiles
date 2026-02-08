return {
  'SUSTech-data/neopyter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'AbaoFromCUG/websocket.nvim',
  },
  ft = 'python',
  ---@type neopyter.Option
  opts = {
    textobject = {
      enable = false,
    },
    on_attach = function(buf)
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = buf })
      end
      map('n', '<leader>x', '<cmd>Neopyter execute notebook:run-cell<cr>', 'run selected')
      map('n', '<leader>X', '<cmd>Neopyter execute notebook:run-all-above<cr>', 'run all above cell')
      map('n', '<space>nt', '<cmd>Neopyter execute kernelmenu:restart<cr>', 'restart kernel')
      map('n', '<S-Enter>', '<cmd>Neopyter execute notebook:run-cell-and-select-next<cr>', 'run selected and select next')
      map('n', '<M-Enter>', '<cmd>Neopyter execute notebook:run-cell-and-insert-below<cr>', 'run selected and insert below')
      map('n', '<F5>', '<cmd>Neopyter execute notebook:restart-run-all<cr>', 'restart kernel and run all')
    end,
  },
}
