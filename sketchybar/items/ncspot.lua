local colors = require("colors")

local ncspot = sbar.add("item", "ncspot", {
	position = "e",
	drawing = "off",
	icon = {
		string = "",
		font = "Hack Nerd Font:Italic:13.0",
		padding_left = 8,
		color = colors.TEXT_SPOTIFY_GREEN,
	},

	background = {
		corner_radius = 10,
		color = colors.BACKGROUND_DARK,
		height = 30,
	},
	label = {
		font = "Comic Sans Ms:Regular:13.0",
		color = colors.TEXT_WHITE,
		max_chars = 15,
		padding_right = 8,
	},
	scroll_texts = true,
	click_script = "ncspot-controller playpause",
	popup = {
		background = {
			border_width = 0,
			border_color = 0x000000,
			corner_radius = 10,
		},
		align = "center",
		y_offset = 0,
	},
})

-- Add popup image item
local img = sbar.add("item", {
	position = "popup." .. ncspot.name,
	background = {
		drawing = "on",
		image = {
			drawing = "on",
			corner_radius = 10,
			scale = 0.5,
		},
		corner_radius = 10,
	},
})

sbar.add("item", "ncspot.img", {
	position = "popup." .. ncspot.name,
	background = {
		drawing = "on",
		image = {
			drawing = "on",
			corner_radius = 10,
			scale = 0.5,
		},
		corner_radius = 10,
	},
})

ncspot:subscribe("mouse.entered", function(env)
	ncspot:set({ popup = { drawing = "toggle" } })
	img:set({ background = { image = { string = "/tmp/ncspot-controller-cover.jpg" } } })
end)

ncspot:subscribe("mouse.exited", function(env)
	ncspot:set({ popup = { drawing = false } })
	img:set({ background = { image = { string = "" } } })
end)
