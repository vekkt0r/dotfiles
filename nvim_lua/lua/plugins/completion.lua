return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      {
        -- snippet plugin
        'L3MON4D3/LuaSnip',
        dependencies = 'rafamadriz/friendly-snippets',
        opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
        config = function(_, opts)
          require('luasnip.loaders.from_snipmate').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets/lua' } }
          require('luasnip.loaders.from_lua').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets/snipmate' } }
        end,
      },
    },
    enabled = true,
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      keymap = {
        preset = 'super-tab',
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      signature = { enabled = true },
    },
  },
}
