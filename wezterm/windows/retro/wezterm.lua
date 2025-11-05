local wezterm = require("wezterm")

return {
  default_prog = {"nu"},
--  color_scheme = "Retro Green",
  color_scheme = "Andromeda",
  window_background_opacity = 90,
  enable_tab_bar = false,
  window_padding = {
    left = 0.5,
    right = 0.5,
    top = 0.5,
    bottom = 0.5,
  },
  font = wezterm.font("Cascadia Mono", {weight="Medium", stretch="Normal", italic=false}),
--  font = wezterm.font("Lucida Sans Typewriter", {weight="Medium", stretch="Normal", italic=false}),
  font_size = 16.0,
  exit_behavior_messaging = "None",
  exit_behavior = "Close",
  window_close_confirmation = "NeverPrompt",
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  window_decorations = "RESIZE",
  default_cursor_style = 'BlinkingBlock', 
  animation_fps = 1,
  cursor_blink_rate = 750,
  cursor_blink_ease_in = "Linear",
  cursor_blink_ease_out = "Linear",
  colors = {
	cursor_bg = "#00FF55",
	cursor_fg = "black",
	cursor_border = "#000000",
  },
  foreground_text_hsb = { hue = 1.0, saturation = 1.0, brightness = 1.15 },
  front_end = "OpenGL",
  keys = {
    {
      key = "v",
      mods = "ALT",
      action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'}
    },
    {
      key = "h",
      mods = "ALT",
      action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain'}
    },
    {
      key = "h",
      mods = "CTRL|ALT",
      action = wezterm.action.ActivatePaneDirection 'Left'
    },
    {
      key = "l",
      mods = "CTRL|ALT",
      action = wezterm.action.ActivatePaneDirection 'Right'
    },
    {
      key = "k",
      mods = "CTRL|ALT",
      action = wezterm.action.ActivatePaneDirection 'Up'
    },
    {
      key = "j",
      mods = "CTRL|ALT",
      action = wezterm.action.ActivatePaneDirection 'Down'
    }
  }
}
