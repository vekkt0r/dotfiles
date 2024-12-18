vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- TODO:
-- path completion
-- snippets
-- toggle bool
-- goto closed file
-- format on save
-- key for clearing telescope prompt
-- thesaurus / dict setup, use lua bindings against Dictionary app

require 'config.lazy'

vim.opt.shiftwidth = 4
vim.opt.ignorecase = true

vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')
vim.keymap.set('n', '<space>x', ':.lua<CR>')
vim.keymap.set('v', '<space>x', ':lua<CR>')

-- Buffer navigation helpers
vim.keymap.set('n', '<leader>a', ':bn<CR>')
vim.keymap.set('n', '<leader>s', ':bp<CR>')
vim.keymap.set('n', '<leader>d', ':bd<CR>')
vim.keymap.set('n', '<leader>e', ':Ex<CR>')

-- Telescope
-- local builtin = require 'telescope.builtin'
local builtin = require 'fzf-lua'
vim.keymap.set('n', '<leader>b', builtin.buffers)
-- vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>ff', builtin.files)
vim.keymap.set('n', '<leader>fg', builtin.lines)
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags)

-- lsp
vim.keymap.set('n', '<leader>m', ':lua vim.lsp.buf.code_action()<CR>')
