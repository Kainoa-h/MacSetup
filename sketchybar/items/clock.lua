local colors = require("colors")

local clock = sbar.add("item", "clock", {
	position = "right",
	update_freq = 10,
	icon = { padding_left = 0 },
	label = {
		color = colors.TEXT_WHITE,
		font = "alarm clock:Regular:18.0",
		padding_right = 10,
	},
	background = {
		color = colors.BACKGROUND_DARK,
		corner_radius = 10,
		height = 30,
	},
})

clock:subscribe({ "routine", "forced", "system_woke" }, function(env)
	clock:set({ label = { string = os.date("%H:%M") } })
end)
