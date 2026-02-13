return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'j-hui/fidget.nvim',
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
              schema = {
                model = {
                  default = 'grok-code-fast-1',
                },
              },
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
        stream = true,
        log_level = 'DEBUG', -- or "TRACE"
      },
    },
    config = function(_, opts)
      require('codecompanion').setup(opts)
      require('plugins.codecompanion.fidget-spinner'):init()
    end,
  },
}
