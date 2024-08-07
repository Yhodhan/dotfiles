local wezterm = require("wezterm")

return {
  color_scheme = "Andromeda",
  window_background_opacity = 0.6,
  enable_tab_bar = false,
  window_padding = {
    left = 0.5,
    right = 0.5,
    top = 0.5,
    bottom = 0.5,
  },
  font_size = 18.0,
  -- font = wezterm.font "Monaco",
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  window_decorations = "NONE",
  window_close_confirmation = "NeverPrompt",
  exit_behavior = "Close",
  exit_behavior_messaging = "None",
  default_cursor_style = 'SteadyBar',
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
      key = "k",
      mods = "SHIFT",
      action = wezterm.action.ActivatePaneDirection 'Up'
    },
    {
      key = "j",
      mods = "SHIFT",
      action = wezterm.action.ActivatePaneDirection 'Down'
    }
  }
}
