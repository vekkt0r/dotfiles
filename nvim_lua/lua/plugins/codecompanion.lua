return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      interactions = {
        chat = {
          adapter = 'abacus',
        },
        inline = {
          adapter = 'abacus',
        },
      },
      adapters = {
        http = {
          abacus = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              env = {
                url = 'https://routellm.abacus.ai',
                api_key = 'ABACUS_API_KEY',
                chat_url = '/v1/chat/completions',
              },
              -- schema = {
              --   model = {
              --     default = 'anthropic/claude-4.5-sonnet',
              --   },
              -- },
            })
          end,
        },
      },
      display = {
        chat = {
          window = {
            layout = 'float',
          },
        },
      },
      opts = {
        stream = false,
        log_level = 'DEBUG', -- or "TRACE"
      },
    },
  },
}
