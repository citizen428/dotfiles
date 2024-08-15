local act = require("wezterm").action

return {
	setup = function(config)
		config.leader = { key = "b", mods = "CTRL" }
		config.keys = {
			-- Make Option-Left equivalent to Alt-b; backward-word
			{ key = "LeftArrow", mods = "OPT", action = act.SendString("\x1bb") },
			-- Make Option-Right equivalent to Alt-f; forward-word
			{ key = "RightArrow", mods = "OPT", action = act.SendString("\x1bf") },
			{
				key = "w",
				mods = "CMD",
				action = act.CloseCurrentPane({ confirm = true }),
			},
			{
				key = "|",
				mods = "CTRL|SHIFT",
				action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
			},
			{
				key = "}",
				mods = "CTRL|SHIFT",
				action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
			},
			{ key = "=", mods = "CTRL", action = act.PaneSelect },
			{
				key = "-",
				mods = "CTRL",
				action = act.PaneSelect({ mode = "SwapWithActive" }),
			},
			{
				key = "h",
				mods = "LEADER",
				action = act.AdjustPaneSize({ "Left", 5 }),
			},
			{
				key = "j",
				mods = "LEADER",
				action = act.AdjustPaneSize({ "Down", 5 }),
			},
			{ key = "k", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
			{
				key = "l",
				mods = "LEADER",
				action = act.AdjustPaneSize({ "Right", 5 }),
			},
			{
				key = "l",
				mods = "ALT",
				action = act.ShowLauncherArgs({ flags = "FUZZY|TABS|DOMAINS" }),
			},
		}
	end,
}
