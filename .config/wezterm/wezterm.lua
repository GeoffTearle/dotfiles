-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)


config.color_scheme = 'colors'

-- This is where you actually apply your config choices
config.font = wezterm.font {
	family = 'FiraCode Nerd Font Mono',
	weight = 'Medium'
}

config.font_size = 11
if wezterm.target_triple == 'aarch64-apple-darwin' then
	config.font_size = 13
end

config.window_background_opacity = 0.5
config.window_decorations = "RESIZE"

config.enable_tab_bar = false

config.scrollback_lines = 3500

-- and finally, return the configuration to wezterm
return config

