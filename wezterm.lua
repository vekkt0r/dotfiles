local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Solarized (dark) (terminal.sexy)"
-- config.font = wezterm.font("Hack Nerd Font Mono", { weight = "Regular" })
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.key_tables = {
  copy_mode = wezterm.gui.default_key_tables().copy_mode,
}
table.insert(config.key_tables.copy_mode, {
  key = "Y",
  mods = "SHIFT",
  action = wezterm.action.Multiple({
    { CopyTo = "ClipboardAndPrimarySelection" },
    { CopyMode = "Close" },
    { PasteFrom = "PrimarySelection" },
    { CopyMode = "ClearSelectionMode" },
  }),
})

local function is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  if pane:get_user_vars().IS_NVIM == "true" then
    return true
  end
  local prog = pane:get_foreground_process_name() or ""
  return prog:find("tmux")
end

local direction_keys = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "resize" and "CTRL|ALT|SHIFT" or "CTRL|ALT",
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == "resize" and "CTRL|ALT|SHIFT" or "CTRL|ALT" },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

local function load_snippets(path)
  local choices = {}
  local home = os.getenv("HOME")
  local file = io.open(home .. "/" .. path, "r")

  if not file then
    return {
      { label = "Snippet file not found", id = nil },
    }
  end

  for line in file:lines() do
    -- skip empty lines
    if line:match("%S") then
      table.insert(choices, {
        label = line,
        id = line,
      })
    end
  end

  file:close()
  return choices
end

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  {
    key = "b",
    mods = "ALT",
    action = wezterm.action.SendKey({ key = "b", mods = "ALT" }),
  },
  {
    key = "f",
    mods = "ALT",
    action = wezterm.action.SendKey({ key = "f", mods = "ALT" }),
  },
  {
    key = "d",
    mods = "ALT",
    action = wezterm.action.SendKey({ key = "d", mods = "ALT" }),
  },
  {
    key = ".",
    mods = "ALT",
    action = wezterm.action.SendKey({ key = ".", mods = "ALT" }),
  },
  {
    key = "Enter",
    mods = "ALT",
    action = wezterm.action.SendKey({ key = "Enter", mods = "ALT" }),
  },
  {
    key = "Enter",
    mods = "SHIFT",
    action = wezterm.action.SendKey({ key = "Enter", mods = "SHIFT" }),
  },
  { key = "-", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
  { key = "=", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
  { key = "s", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "v", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
  { key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
  {
    key = "s",
    mods = "LEADER|CTRL",
    action = wezterm.action.InputSelector({
      title = "Snippets",
      fuzzy = true,
      choices = load_snippets(".snippets"),

      action = wezterm.action_callback(function(window, pane, id, label)
        if id then
          pane:send_text(id)
        end
      end),
    }),
  },
  -- move between split panes
  split_nav("move", "h"),
  split_nav("move", "j"),
  split_nav("move", "k"),
  split_nav("move", "l"),
  -- resize panes
  split_nav("resize", "h"),
  split_nav("resize", "j"),
  split_nav("resize", "k"),
  split_nav("resize", "l"),
}

-- Tab navigation keys
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

config.use_ime = false

wezterm.on("user-var-changed", function(window, pane, name, value)
  if name == "open_url" then
    if value:match("^https?://") or value:match("^file://") then
      wezterm.open_with(value)
    else
      window:toast_notification("wezterm", "Ignore open_url for " .. value, nil, 4000)
    end
  end
end)

config.ssh_domains = {
  { name = "buildarn", remote_address = "buildarn", username = "adam" },
}

return config
