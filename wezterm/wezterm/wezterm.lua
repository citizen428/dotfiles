local config = require("wezterm").config_builder()

config.term = "wezterm"
config.audible_bell = "Disabled"

require("ui").setup(config)
require("keys").setup(config)
require("mouse").setup(config)

return config
