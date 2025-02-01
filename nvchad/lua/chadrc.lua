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

return M
