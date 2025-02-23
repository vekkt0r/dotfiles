require "nvchad.mappings"

local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

map("n", "<Leader>o", "<Cmd>ClangdSwitchSourceHeader<CR>")

-- Diff / mergetool
if vim.wo.diff then
  map("n", "<Leader>1", ":diffget LOCAL<CR>")
  map("n", "<Leader>2", ":diffget BASE<CR>")
  map("n", "<Leader>3", ":diffget REMOTE<CR>")
end

-- Git

--- Open floating terminal with some extra hacks to close it on cmd exit
local term = function(cmd, args, keep)
  args = args or vim.fn.expand "%"
  args = type(args) == "function" and args() or args
  require("nvchad.term").new {
    cmd = cmd .. " " .. args .. " #", -- end with # to disable nvchad launch of shell after command
    pos = "float",
    termopen_opts = {
      detach = false,
      on_exit = function(_, data, _)
        if data == 0 and not keep then
          vim.cmd "close"
          vim.cmd "checktime"
        end
      end,
    },
  }
end

local git_commands = {
  blame = {
    key = "<Leader>cb",
    cmd = "tig blame",
    args = function()
      return (vim.fn.expand "%" .. " +" .. vim.api.nvim_win_get_cursor(0)[1])
    end,
  },
  diff = { key = "<Leader>cd", cmd = "git diff", keep = true },
  log = { key = "<Leader>cl", cmd = "tig" },
  status = { key = "<Leader>cs", cmd = "tig status", args = "" },
  revert = { key = "<Leader>cv", cmd = "git checkout -p" },
}

for k, v in pairs(git_commands) do
  map("n", v.key, function()
    term(v.cmd, v.args, v.keep)
  end, { desc = "Git " .. k })
end

-- Telescope
local builtin = require "telescope.builtin"
map("n", "<leader><leader>", builtin.buffers)
map("n", "<leader>fr", builtin.resume)
map("n", "<leader>A", builtin.grep_string)

-- Molten
map("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
map("n", "<leader>rj", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
map("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
map("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
map("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "evaluate visual selection" })

-- Disable mappings
local nomap = vim.keymap.del

nomap("n", "<C-h>")
nomap("n", "<C-l>")
nomap("n", "<C-j>")
nomap("n", "<C-k>")
