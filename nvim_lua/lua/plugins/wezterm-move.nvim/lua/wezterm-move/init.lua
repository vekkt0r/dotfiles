local WM = {}

local wezterm_directions = { h = "Left", j = "Down", k = "Up", l = "Right" }

local function is_floating_window(win_id)
  win_id = win_id or 0
  local win_cfg = vim.api.nvim_win_get_config(win_id)
  return win_cfg and win_cfg.relative ~= ""
end

-- @param direction: string (h, j, k, l)
local function at_edge(direction)
  return is_floating_window() or vim.fn.winnr() == vim.fn.winnr(direction)
end

local function wezterm_exec(cmd)
  local command = vim.deepcopy(cmd)
  if vim.fn.executable("wezterm.exe") == 1 then
    table.insert(command, 1, "wezterm.exe")
  else
    table.insert(command, 1, "wezterm")
  end
  table.insert(command, 2, "cli")
  return vim.fn.system(command)
end

-- @param direction: string (h, j, k, l)
local function send_key_to_wezterm(direction)
  wezterm_exec({ "activate-pane-direction", wezterm_directions[direction] })
end

-- @param direction: string (h, j, k, l)
WM.move = function(direction)
  if at_edge(direction) then
    send_key_to_wezterm(direction)
  else
    vim.cmd("wincmd " .. direction)
  end
end

return WM
