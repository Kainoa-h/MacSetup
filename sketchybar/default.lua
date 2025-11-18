local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
  padding_left = 5,
  padding_right = 5,
  icon = {
    font = "Hack Nerd Font:Bold:17.0",
    color = colors.TEXT_GREY,
    padding_left = 4,
    padding_right = 4,
  },
  label = {
    font = "SF Pro:Semibold:17.0",
    color = colors.TEXT_GREY,
    padding_left = 4,
    padding_right = 4,
  },
  updates = "on",
  y_offset = -3,
})
