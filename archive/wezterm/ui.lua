return {
	setup = function(config)
		config.color_scheme = "nord"
		config.font = require("wezterm").font("FiraCode Nerd Font Mono", { weight = "Medium" })
		config.font_size = 14.0
		config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
		config.window_frame = { font_size = 14.0 }

		-- Place window management buttons into the tab bar instead title bar.
		config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
	end,
}
