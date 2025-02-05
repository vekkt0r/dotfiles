---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "solarized_dark",
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

M.term = {
  float = {
    row = 0.1,
    col = 0.1,
    width = 0.8,
    height = 0.8,
  },
}

local utils = require "nvchad.stl.utils"

M.ui = {
  statusline = {
    modules = {
      file = function()
        local sep_r = utils.separators["default"]["right"]
        local x = utils.file()
        x[2] = vim.fn.expand "%"
        local name = " " .. x[2] .. " "
        return "%#St_file# " .. x[1] .. name .. "%#St_file_sep#" .. sep_r
      end,
    },
  },
}

return M
