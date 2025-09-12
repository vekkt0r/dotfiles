return {
  {
    'saghen/blink.cmp',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      {
        'L3MON4D3/LuaSnip',
        dependencies = 'rafamadriz/friendly-snippets',
        opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
        config = function(_, opts)
          require('luasnip').config.set_config(opts)
          require('luasnip.loaders.from_lua').load()
          require('luasnip.loaders.from_lua').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets/lua' } }
          require('luasnip.loaders.from_snipmate').load()
          require('luasnip.loaders.from_snipmate').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets/snipmate' } }
        end,
      },
    },
    enabled = true,
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      snippets = { preset = 'luasnip' },
      keymap = {
        preset = 'super-tab',
      },

      sources = {
        default = { 'jupynium', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          jupynium = {
            name = 'Jupynium',
            module = 'jupynium.blink_cmp',
            score_offset = 100,
          },
        },
      },

      signature = { enabled = true },
    },
  },
}
