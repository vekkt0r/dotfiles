vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local o = vim.o
o.mouse = ''
o.clipboard = ''
o.scrolloff = 10

local map = vim.keymap.set

-- TODO:
-- path completion
-- snippets
-- goto closed file
-- format on save

require 'config.lazy'

vim.opt.shiftwidth = 4
vim.opt.ignorecase = true

map('i', 'jk', '<ESC>')
map('i', 'kj', '<ESC>')
map('n', '<Esc>', '<cmd>noh<CR>', { desc = 'general clear highlights' })

-- Diff / mergetool
if vim.wo.diff then
  map('n', '<Leader>1', ':diffget LOCAL<CR>')
  map('n', '<Leader>2', ':diffget BASE<CR>')
  map('n', '<Leader>3', ':diffget REMOTE<CR>')
end

--map('n', '<space><space>x', '<cmd>source %<CR>')
map('n', '<space>x', ':.lua<CR>')
map('v', '<space>x', ':lua<CR>')

map('n', '<leader>/', 'gcc', { desc = 'toggle comment', remap = true })
map('v', '<leader>/', 'gc', { desc = 'toggle comment', remap = true })

-- Buffer navigation helpers
map('n', '<leader>a', ':bn<CR>')
map('n', '<leader>s', ':bp<CR>')

-- Telescope
-- local builtin = require 'telescope.builtin'
local builtin = require 'fzf-lua'
map('n', '<leader><leader>', builtin.buffers)
map('n', '<leader>fr', builtin.resume)
map('n', '<leader>A', builtin.grep_cword)
-- map('n', '<leader>ff', builtin.find_files)
map('n', '<leader>ff', builtin.files)
map('n', '<leader>fg', builtin.lines)
map('n', '<leader>fo', builtin.oldfiles)
-- map('n', '<leader>fh', builtin.help_tags)

-- lsp
map('n', '<leader>m', ':lua vim.lsp.buf.code_action()<CR>')
map('n', '<Leader>o', '<Cmd>ClangdSwitchSourceHeader<CR>')

-- Molten
map('n', '<leader>mi', ':MoltenInit<CR>', { silent = true, desc = 'Initialize the plugin' })
map('n', '<leader>rj', ':MoltenEvaluateOperator<CR>', { silent = true, desc = 'run operator selection' })
map('n', '<leader>rl', ':MoltenEvaluateLine<CR>', { silent = true, desc = 'evaluate line' })
map('n', '<leader>rr', ':MoltenReevaluateCell<CR>', { silent = true, desc = 're-evaluate cell' })
map('v', '<leader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { silent = true, desc = 'evaluate visual selection' })
map({ 'n', 'v' }, '<leader>ro', ':noautocmd MoltenEnterOutput<CR>', { silent = true, desc = 'show/enter output' })

-- Git

local term = function(cmd, args, keep)
  args = args or vim.fn.expand '%'
  args = type(args) == 'function' and args() or args
  require('snacks').terminal.open(cmd .. ' ' .. args, { auto_close = not keep })
end

local git_commands = {
  blame = {
    key = '<Leader>cb',
    cmd = 'tig blame',
    args = function()
      return (vim.fn.expand '%' .. ' +' .. vim.api.nvim_win_get_cursor(0)[1])
    end,
  },
  diff = { key = '<Leader>cd', cmd = 'git diff', keep = true },
  log = { key = '<Leader>cl', cmd = 'tig' },
  status = { key = '<Leader>cs', cmd = 'tig status', args = '' },
  revert = { key = '<Leader>cv', cmd = 'git checkout -p' },
}

for k, v in pairs(git_commands) do
  map('n', v.key, function()
    term(v.cmd, v.args, v.keep)
  end, { desc = 'Git ' .. k })
end
