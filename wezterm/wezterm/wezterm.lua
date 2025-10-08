local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

config.term = "xterm-256color"
config.audible_bell = "Disabled"

require("ui").setup(config)
require("keys").setup(config)
require("mouse").setup(config)

wezterm.on("gui-startup", function()
	-- Define the 'rapidquote' workspace
	local project_dir = wezterm.home_dir .. "/work/rapidquote"
	local tab1, _, window = mux.spawn_window({
		workspace = "rapidquote",
		cwd = project_dir .. "/extension",
	})
	tab1:set_title("Extension")

	local tab2 = window:spawn_tab({
		cwd = project_dir .. "/backend",
	})
	tab2:set_title("Backend")

  local tab3 = window:spawn_tab({
    cwd = wezterm.home_dir .. "/work/al3-converter"
  })
  tab3:set_title("AL3")

	tab1:activate()

	-- Define the 'default' workspace
	mux.spawn_window({ workspace = "default" })
	mux.set_active_workspace("default")
end)

return config
