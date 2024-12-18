return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'saghen/blink.cmp' },
  },
  config = function()
    local servers = {
      ruff = {},
      jedi_language_server = {},
      clangd = {},
      -- fish_lsp = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    require('mason').setup()

    require('mason-tool-installer').setup { ensure_installed = { 'stylua' } }

    local ensure_installed = vim.tbl_keys(servers or {})
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    require('mason-lspconfig').setup {
      ensure_installed = ensure_installed,
      automatic_installation = true,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    -- require('lspconfig').lua_ls.setup { capabilities = capabilities }
    -- require('lspconfig').ruff.setup { capabilities = capabilities }
    -- require('lspconfig').jedi_language_server.setup { capabilities = capabilities }
  end,
}
