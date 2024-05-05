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
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  window_decorations = "NONE",
  keys = {
    -- {
    --   key = "RightArrow",
    --   mods = "ALT",
    --   action = wezterm.action.
    -- }
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
    -- {
    --   key = "h",
    --   mods = "SHIFT",
    --   action = wezterm.action.ActivatePaneDirection 'Left'
    -- },
    -- {
    --   key = "l",
    --   mods = "SHIFT",
    --   action = wezterm.action.ActivatePaneDirection 'Right'
    -- }
  }
}
