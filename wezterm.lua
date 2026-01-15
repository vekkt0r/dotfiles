local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Solarized (dark) (terminal.sexy)"
config.font = wezterm.font("Hack Nerd Font Mono")
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
}

config.use_ime = false

return config
