local colors = require("colors")

sbar.add("item", "kan", {
	position = "e",
	icon = { string = "", font = "Hack Nerd Font:Bold:17.0", padding_left = 8 },
	label = {
		string = "main",
		font = "Hack Nerd Font:Italic:13.0",
		padding_right = 8,
	},
	background = {
		corner_radius = 10,
		color = colors.BACKGROUND_DARK,
		height = 30,
	},
})
