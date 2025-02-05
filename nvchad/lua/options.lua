require "nvchad.options"

local o = vim.o
o.mouse = ""
o.clipboard = ""

local opt = vim.opt
opt.whichwrap:remove { "<>[]hl" }
