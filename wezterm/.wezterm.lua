-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.term = "wezterm"

config.color_scheme = 'nord'

config.font = wezterm.font('FiraCode Nerd Font Mono', { weight = 'Medium' })
config.font_size = 14.0
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"

config.window_frame = {
  font_size = 14.0
}

-- Place window management buttons into the tab bar instead title bar.
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.audible_bell = "Disabled"

config.leader = { key = 'b', mods = 'CTRL' }
config.keys = {
  -- Make Option-Left equivalent to Alt-b; backward-word
  { key = 'LeftArrow', mods = 'OPT', action = act.SendString '\x1bb' },
  -- Make Option-Right equivalent to Alt-f; forward-word
  { key = 'RightArrow', mods = 'OPT', action = act.SendString '\x1bf' },
  {
    key = 'w',
    mods = 'CMD',
    action = act.CloseCurrentPane { confirm = true }
  },
  {
    key = '|',
    mods = 'CTRL|SHIFT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
  {
    key = '}',
    mods = 'CTRL|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  { key = '=', mods = 'CTRL', action = act.PaneSelect },
  {
    key = '-',
    mods = 'CTRL',
    action = act.PaneSelect { mode = 'SwapWithActive' }
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Down', 5 },
  },
  { key = 'k', mods = 'LEADER', action = act.AdjustPaneSize { 'Up', 5 } },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 'l',
    mods = 'ALT',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS|DOMAINS' },
  },
}

-- return the configuration to wezterm
return config
