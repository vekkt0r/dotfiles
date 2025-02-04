require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- Git

--- Open floating terminal with some extra hacks to close it on cmd exit
local term = function(cmd, args)
  args = args or vim.api.nvim_buf_get_name(0)
  require("nvchad.term").new {
    cmd = cmd .. " " .. args .. " #", -- end with # to disable nvchad launch of shell after command
    pos = "float",
    termopen_opts = {
      detach = false,
      on_exit = function(_, data, _)
        if data == 0 then
          vim.cmd "close"
        end
      end,
    },
  }
end

local git_commands = {
  blame = { key = "<Leader>cb", cmd = "tig blame" },
  diff = { key = "<Leader>cd", cmd = "git diff" },
  log = { key = "<Leader>cl", cmd = "tig" },
  status = { key = "<Leader>cs", cmd = "tig status", args = "" },
  revert = { key = "<Leader>cv", cmd = "git checkout -p" },
}

for k, v in pairs(git_commands) do
  map("n", v.key, function()
    term(v.cmd, v.args or nil)
  end, { desc = "Git " .. k })
end

-- Telescope
local builtin = require "telescope.builtin"
map("n", "<leader><leader>", builtin.buffers)
map("n", "<leader>fr", builtin.resume)

-- Disable mappings
local nomap = vim.keymap.del

nomap("n", "<C-h>")
nomap("n", "<C-l>")
nomap("n", "<C-j>")
nomap("n", "<C-k>")
