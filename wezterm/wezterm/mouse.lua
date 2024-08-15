local act = require("wezterm").action

return {
	setup = function(config)
		config.mouse_bindings = {
			-- Change the default click behavior so that it only selects
			-- text and doesn't open hyperlinks
			{
				event = { Up = { streak = 1, button = "Left" } },
				mods = "NONE",
				action = act.CompleteSelection("Clipboard"),
			},
			-- and make CMD-Click open hyperlinks
			{
				event = { Up = { streak = 1, button = "Left" } },
				mods = "CMD",
				action = act.OpenLinkAtMouseCursor,
			},
		}
	end,
}
