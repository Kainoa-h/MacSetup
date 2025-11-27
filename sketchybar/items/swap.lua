local colors = require("colors")

local swap = sbar.add("item", "swap", {
	position = "e",
	update_freq = 60,
	icon = { string = "", font = "Hack Nerd Font:Italic:13.0", padding_left = 8, color = colors.TEXT_RED },
	label = {
		font = "Hack Nerd Font:Italic:13.0",
		padding_right = 8,
		color = colors.TEXT_RED,
	},
	background = {
		corner_radius = 10,
		color = colors.BACKGROUND_DARK,
		height = 30,
	},
	drawing = "off",
	click_script = "open -a 'Activity Monitor'",
})

swap:subscribe({ "routine", "system_woke" }, function(env)
	sbar.exec("sysctl vm.swapusage | awk '{print $4}'", function(result)
		result = result:match("^%s*(.*%S)%s*$")
		if result == "0.00M" then
			swap:set({
				drawing = "off",
			})
		else
			swap:set({
				drawing = "on",
				label = {
					string = result,
				},
			})
		end
	end)
end)
