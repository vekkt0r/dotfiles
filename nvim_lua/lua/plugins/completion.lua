return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    enabled = true,

    build = 'cargo build --release',

    -- use a release tag to download pre-built binaries
    version = 'v0.11.0',

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
