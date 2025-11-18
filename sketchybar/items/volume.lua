local colors = require("colors")

local volume = sbar.add("item", "volume", {
	position = "right",
})

volume:subscribe("volume_change", function(env)
	local volume_info = tonumber(env.INFO) or 0
	local icon = "󰖀"
	if volume_info == 0 then
		icon = "󰖁"
	elseif volume_info > 50 then
		icon = "󰕾"
	end

	volume:set({
		icon = { string = icon },
		label = { string = string.format("%d%%", volume_info) },
	})
end)

-- Trigger initial update
sbar.trigger("volume_change")
