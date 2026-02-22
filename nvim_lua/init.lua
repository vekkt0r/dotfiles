vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.python3_host_prog = '/usr/local/bin/python3'

local o = vim.o
o.mouse = ''
o.clipboard = ''
o.scrolloff = 10
o.updatetime = 500

local map = vim.keymap.set

-- TODO:

require 'config.lazy'

vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = -1
vim.opt.ignorecase = true
vim.opt.winborder = 'rounded'

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
map('n', '<space>X', function()
  if vim.o.filetype == 'lua' then
    vim.cmd '.lua'
  else
    vim.cmd 'JupyniumExecuteSelectedCells'
  end
end)
map('v', '<space>X', ':lua<CR>')

map('n', '<leader>/', 'gcc', { desc = 'toggle comment', remap = true })
map('v', '<leader>/', 'gc', { desc = 'toggle comment', remap = true })

-- Buffer navigation helpers
map('n', '<leader>a', ':bn<CR>')
map('n', '<leader>s', ':bp<CR>')

vim.diagnostic.config {
  float = {
    border = 'single',
  },
}

-- Redirect Ex command to buffer
vim.api.nvim_exec(
  [[
command! -nargs=* -complete=command Redirect <mods> new | setl nonu nolist noswf bh=wipe bt=nofile | call append(0, split(execute(<q-args>), "\n"))
]],
  false
)

-- Fzf-lua
local builtin = require 'fzf-lua'
map('n', '<leader><leader>', builtin.buffers)
map('n', '<leader>fr', builtin.resume)
map('n', '<leader>fw', builtin.grep_cword)
map('n', '<leader>ff', builtin.files)
map('n', '<leader>fg', builtin.grep_project)
map('n', '<leader>fo', builtin.oldfiles)
-- map('n', '<leader>fh', builtin.help_tags)

-- lsp
map('n', '<leader>m', ':lua vim.lsp.buf.code_action()<CR>')
map('n', '<Leader>o', '<Cmd>LspClangdSwitchSourceHeader<CR>')

-- Molten
map('n', '<leader>mi', ':MoltenInit<CR>', { silent = true, desc = 'Initialize the plugin' })
map('n', '<leader>rj', ':MoltenEvaluateOperator<CR>', { silent = true, desc = 'run operator selection' })
map('n', '<leader>rl', ':MoltenEvaluateLine<CR>', { silent = true, desc = 'evaluate line' })
map('n', '<leader>rr', ':MoltenReevaluateCell<CR>', { silent = true, desc = 're-evaluate cell' })
map('v', '<leader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { silent = true, desc = 'evaluate visual selection' })
map({ 'n', 'v' }, '<leader>ro', ':noautocmd MoltenEnterOutput<CR>', { silent = true, desc = 'show/enter output' })

-- Jupynium
map('n', '<leader>jS', ':JupyniumStartAndAttachToServer<CR>', { silent = true, desc = 'Start backend' })
map('n', '<leader>jc', ':JupyniumClearSelectedCellsOutputs<CR>', { silent = true, desc = 'Clear current cell output' })
map('n', '<leader>js', function()
  vim.cmd 'JupyniumStartSync'
end, { silent = true, desc = 'Start syncing current file' })

-- CodeCompanion
vim.cmd [[cab cc CodeCompanion]]
map('n', '<leader>cc', ':CodeCompanionChat Toggle<CR>', { silent = true, desc = 'Open CodeCompanionChat buffer' })
map('n', '<leader>cn', ':CodeCompanionChat<CR>', { silent = true, desc = 'Open new CodeCompanionChat buffer' })

-- Git

local term = function(cmd, args, keep)
  args = args or vim.fn.expand '%'
  args = type(args) == 'function' and args() or args
  require('snacks').terminal.open(cmd .. ' ' .. args, { auto_close = not keep, win = { border = 'rounded' } })
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

-- Terminal specific
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*',
  callback = function()
    vim.keymap.set('n', '<Esc>', 'i', { buffer = true })
    vim.keymap.set('n', '<C-p>', 'i<C-p>', { buffer = true })
  end,
})
