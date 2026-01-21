return {
  {
    'saghen/blink.cmp',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
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
        default = { 'neopyter', 'lsp', 'path', 'snippets', 'buffer', 'codecompanion' },
        per_filetype = {
          python = { inherit_defaults = true, 'neopyter' },
        },
        providers = {
          neopyter = {
            name = 'Neopyter',
            module = 'neopyter.blink',
            ---@type neopyter.BlinkCompleterOption
            opts = {},
          },
        },
      },

      signature = { enabled = true },
    },
  },
}
