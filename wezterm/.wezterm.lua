local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.colors = require("cyberdream")
config.enable_tab_bar = true
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14.0
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
	{
		key = "c",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }), pane)
				window:perform_action("ClearSelection", pane)
			else
				window:perform_action(wezterm.action({ SendKey = { key = "c", mods = "CTRL" } }), pane)
			end
		end),
	},
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wezterm.action({ SendKey = { key = "c", mods = "CTRL" } }),
	},
	{
		key = "v",
		mods = "CTRL",
		action = wezterm.action({ PasteFrom = "Clipboard" }),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action({ SendKey = { key = "v", mods = "CTRL" } }),
	},
}
config.scrollback_lines = 3500

return config
