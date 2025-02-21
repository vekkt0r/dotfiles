return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = require "configs.cmp",
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "echasnovski/mini.surround",
    event = "User FilePost",
    version = false,
    opts = {},
  },

  {
    "Vigemus/iron.nvim",
    ft = { "python", "sh" },
    event = "User FilePost",
    opts = require "configs.iron",
  },

  {
    "gerazov/toggle-bool.nvim",
    event = "VeryLazy",
    opts = {
      mapping = "<leader>T",
      additional_toggles = {
        Yes = "No",
        On = "Off",
        ["0"] = "1",
        Enable = "Disable",
        Enabled = "Disabled",
      },
    },
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
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "kelly-lin/telescope-ag" },
    },
    opts = function(_, conf)
      -- TODO: Only for buffer picker
      conf.defaults.mappings.i = {
        ["<C-k>"] = "delete_buffer",
      }
      require("telescope").load_extension "ag"
      require("telescope").load_extension "fzf"
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
