local colors = require("colors")

-- Right items bracket
sbar.add("bracket", "rightItems", { "volume", "battery", "wifi" }, {
	background = {
		color = colors.BACKGROUND,
		corner_radius = 10,
		height = 30,
	},
})
