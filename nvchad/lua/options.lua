require "nvchad.options"

local o = vim.o
o.mouse = ""
o.clipboard = ""
o.scrolloff = 10

local opt = vim.opt
opt.whichwrap:remove { "<>[]hl" }
