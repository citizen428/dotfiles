local wezterm = require("wezterm")
local act = wezterm.action

local function map(mods, key, action)
	return { mods = mods, key = key, action = action }
end

local function resize_pane(key, direction)
	return { key = key, action = act.AdjustPaneSize({ direction, 5 }) }
end

return {
	setup = function(config)
		config.leader = { mods = "CTRL", key = "a" }

		config.keys = {
			-- Send CTRL-A in leader mode by quickly pressing it twice
			map("LEADER|CTRL", "a", act.SendKey({ mods = "CTRL", key = "a" })),
			-- Make Option-Left equivalent to Alt-b; backward-word
			map("OPT", "LeftArrow", act.SendString("\x1bb")),
			-- Make Option-Right equivalent to Alt-f; forward-word
			map("OPT", "RightArrow", act.SendString("\x1bf")),
			-- Use Shift-Enter to add newline without sending the current line
			map("SHIFT", "Enter", act.SendString("\x1b\r")),
			map("CMD", "w", act.CloseCurrentPane({ confirm = true })),
			map("CTRL|SHIFT", "|", act.SplitHorizontal({ domain = "CurrentPaneDomain" })),
			map("CTRL|SHIFT", "}", act.SplitVertical({ domain = "CurrentPaneDomain" })),
			map("CTRL", "=", act.PaneSelect),
			map("CTRL", "-", act.PaneSelect({ mode = "SwapWithActive" })),
			map("ALT", "l", act.ShowLauncherArgs({ flags = "FUZZY|TABS|DOMAINS" })),
			map("ALT", "w", act.ShowLauncherArgs({ flags = "WORKSPACES" })),
			map("LEADER", "h", act.ActivatePaneDirection("Left")),
			map("LEADER", "j", act.ActivatePaneDirection("Down")),
			map("LEADER", "k", act.ActivatePaneDirection("Up")),
			map("LEADER", "l", act.ActivatePaneDirection("Right")),
			map(
				"LEADER",
				"r",
				act.ActivateKeyTable({ name = "resize_panes", one_shot = false, timeout_milliseconds = 500 })
			),
			map(
				"LEADER",
				"t",
				wezterm.action_callback(function(window, _)
					window:set_config_overrides({ color_scheme = "Solarized Light (Gogh)" })
				end)
			),
			map(
				"LEADER",
				"c",
				wezterm.action_callback(function(window, _)
					window:set_config_overrides({})
				end)
			),
			map("CTRL", "`", act.TogglePaneZoomState),
		}

		config.key_tables = {
			resize_panes = {
				resize_pane("h", "Left"),
				resize_pane("j", "Down"),
				resize_pane("k", "Up"),
				resize_pane("l", "Right"),
			},
		}
	end,
}
