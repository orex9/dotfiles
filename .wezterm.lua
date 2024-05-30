local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.enable_tab_bar = true
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 13.0
config.color_scheme = "Argonaut (Gogh)"
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}
config.hide_tab_bar_if_only_one_tab = true
config.initial_rows = 50
config.initial_cols = 232
config.keys = {
	{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{ key = "c", mods = "CTRL", action = wezterm.action({ CopyTo = "Clipboard" }) },
}

return config
