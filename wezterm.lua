local wezterm = require("wezterm")

return {
  default_prog = {"nu"},
  color_scheme = "Andromeda",
  -- window_background_opacity = 0.8,
  enable_tab_bar = false,
  window_padding = {
    left = 0.5,
    right = 0.5,
    top = 0.5,
    bottom = 0.5,
  },
  exit_behavior_messaging = "None",
  exit_behavior = "Close",
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  window_decorations = "RESIZE",
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
      key = "j",
      mods = "CTRL",
      action = wezterm.action.ActivatePaneDirection 'Left'
    },
    {
      key = ";",
      mods = "CTRL",
      action = wezterm.action.ActivatePaneDirection 'Right'
    },
    {
      key = "k",
      mods = "CTRL",
      action = wezterm.action.ActivatePaneDirection 'Up'
    },
    {
      key = "l",
      mods = "CTRL",
      action = wezterm.action.ActivatePaneDirection 'Down'
    }
  }
}
