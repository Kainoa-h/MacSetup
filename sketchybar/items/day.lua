local colors = require("colors")

sbar.add("item", "day", {
  position = "e",
  label = { max_chars = 20 },
  icon = {
    padding_left = 2,
    padding_right = 0,
    font = "sketchybar-app-font:Regular:16.0",
    string = ":obsidian:",
  },
  label = {
    padding_left = 2,
    padding_right = 2,
    font = "Comic Sans Ms:Regular:13.0",
    color = colors.TEXT_GREY,
  },
  background = {
    corner_radius = 10,
    color = colors.BACKGROUND,
    height = 30,
  },
  scroll_texts = true,
  drawing = "off",
})
