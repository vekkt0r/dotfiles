local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- TODO:
-- Better tab names, check process completion

config.color_scheme = "Solarized (dark) (terminal.sexy)"
-- config.font = wezterm.font("Hack Nerd Font Mono", { weight = "Regular" })
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
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

-- Plugins
--
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm.git")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local function temperature()
  local now = os.time()
  local cached = wezterm.GLOBAL.temperature
  if cached and cached.timestamp and (now - cached.timestamp) < 600 then
    return cached.value
  end
  local handle =
    io.popen("curl -s 'http://api.temperatur.nu/tnu_1.12.php?p=valla&verbose&cli=" .. math.random(100000) .. "'")
  if handle then
    local result = handle:read("*a")
    handle:close()
    local temp_match = result:match("<temp>(.-)</temp>")
    if temp_match then
      local temp = temp_match .. "°"
      wezterm.GLOBAL.temperature = { value = temp, timestamp = now }
      return temp
    else
      return "N/A"
    end
  else
    return "N/A"
  end
end

-- Custom mode indicator for leader
if not require("tabline.config").component_opts then -- only init once
  local get_mode = require("tabline.components.window.mode").get
  local mode_with_leader = function(window)
    if window:leader_is_active() then
      return "leader_mode"
    else
      return get_mode(window)
    end
  end
  require("tabline.components.window.mode").get = mode_with_leader
end

tabline.setup({
  options = {
    icons_enabled = false,
    section_separators = "",
    component_separators = "",
    tab_separators = "",
    theme_overrides = {
      leader_mode = {
        a = { fg = "#000000", bg = "#ff0000" },
        b = { fg = "#000000", bg = "#ff0000" },
        c = { fg = "#000000", bg = "#ff0000" },
      },
    },
  },
  sections = {
    tab_active = { { "index", zero_indexed = true }, { "cwd", padding = { left = 0, right = 1 } } },
    tab_inactive = { { "index", zero_indexed = true }, { "cwd", padding = { left = 0, right = 1 } } },
    tabline_b = { "workspace", icons_enabled = false },
    tabline_x = { temperature },
    tabline_y = { wezterm.strftime(" %H:%M | W%V ") },
  },
})
tabline.apply_to_config(config)

-- Key bindings
--
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

config.leader = { key = "x", mods = "CTRL", timeout_milliseconds = 1000 }
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
  { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
  { key = "l", mods = "LEADER", action = wezterm.action.ActivateLastTab },
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
  -- resurrect
  {
    key = "S",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      win:toast_notification("wezterm", "Saving resurrect state", nil, 4000)
      resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
      resurrect.window_state.save_window_action()
    end),
  },
  {
    key = "r",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
        local type = string.match(id, "^([^/]+)") -- match before '/'
        id = string.match(id, "([^/]+)$") -- match after '/'
        id = string.match(id, "(.+)%..+$") -- remove file extention
        local opts = {
          relative = true,
          restore_text = true,
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        }
        if type == "workspace" then
          local state = resurrect.state_manager.load_state(id, "workspace")
          resurrect.workspace_state.restore_workspace(state, opts)
        elseif type == "window" then
          local state = resurrect.state_manager.load_state(id, "window")
          resurrect.window_state.restore_window(pane:window(), state, opts)
        elseif type == "tab" then
          local state = resurrect.state_manager.load_state(id, "tab")
          resurrect.tab_state.restore_tab(pane:tab(), state, opts)
        end
      end)
    end),
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
for i = 0, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i),
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
