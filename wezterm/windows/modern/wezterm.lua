local wezterm = require("wezterm")

return {
  default_prog = {"nu"},
  color_scheme = "Galizur",
  window_background_opacity = .90,
  window_close_confirmation = 'AlwaysPrompt',
  enable_tab_bar = false,
  window_padding = {
    left = 0.5,
    right = 0.5,
    top = 0.5,
    bottom = 0.5,
  },
  font = wezterm.font("Cascadia Mono", {weight="Medium", stretch="Normal", italic=false}),
  font_size = 16.0,
  exit_behavior_messaging = "None",
  exit_behavior = "Close",
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  window_decorations = "RESIZE",
  default_cursor_style = 'SteadyBar', 
  colors = {
	cursor_bg = "f92660",
	cursor_fg = "black",
	cursor_border = "f92660",
  },
  keys = {
    {
      key = "v",
      mods = "CTRL|ALT",
      action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'}
    },
    {
      key = "h",
      mods = "CTRL|ALT",
      action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain'}
    },
    {
      key = "h",
      mods = "CTRL|SHIFT",
      action = wezterm.action.ActivatePaneDirection 'Left'
    },
    {
      key = "l",
      mods = "CTRL|SHIFT",
      action = wezterm.action.ActivatePaneDirection 'Right'
    },
    {
      key = "k",
      mods = "CTRL|SHIFT",
      action = wezterm.action.ActivatePaneDirection 'Up'
    },
    {
      key = "j",
      mods = "CTRL|SHIFT",
      action = wezterm.action.ActivatePaneDirection 'Down'
    }
  }
}
