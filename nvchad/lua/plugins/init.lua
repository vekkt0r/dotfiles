return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "tpope/vim-sleuth",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "echasnovski/mini.surround",
    event = "User FilePost",
    version = false,
    opts = {},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "bash",
        "c",
        "diff",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      -- TODO: Only for buffer picker
      conf.defaults.mappings.i = {
        ["<C-k>"] = "delete_buffer",
      }
      return conf
    end,
  },

  {
    "alexghergh/nvim-tmux-navigation",
    event = "User FilePost",
    config = function()
      require("nvim-tmux-navigation").setup {
        keybindings = {
          left = "<C-M-h>",
          down = "<C-M-j>",
          up = "<C-M-k>",
          right = "<C-M-l>",
          last_active = "<C-\\>",
        },
      }
    end,
  },
}
