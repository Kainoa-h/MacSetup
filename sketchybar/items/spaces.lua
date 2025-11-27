local colors = require("colors")
local icon_map = require("helpers.icon_map")

-- Helper function to execute shell commands and get output
local function exec(command)
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()
	return result:gsub("%s+$", "")
end

-- Helper function to get lines from command output
local function exec_lines(command)
	local lines = {}
	for line in exec(command):gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end
	return lines
end

-- Module-level state storage (persists between update calls)
local full_workspace_template = {}
local workspace_states = {}

-- Add aerospace events
sbar.add("event", "aerospace_workspace_change")
sbar.add("event", "aerospace_monitor_change")

-- Create space items for all aerospace workspaces
local all_workspaces = exec_lines("aerospace list-workspaces --all")

for _, sid in ipairs(all_workspaces) do
	-- Determine which monitor this workspace is on
	local monitor_id = exec(
		string.format(
			"aerospace list-windows --workspace %s --format '%%{monitor-appkit-nsscreen-screens-id}' | cut -c1",
			sid
		)
	)
	if monitor_id == "" then
		monitor_id = "1"
	end

	-- Create space item
	sbar.add("item", "space." .. sid, {
		position = "left",
		display = monitor_id,
		drawing = "off",
		background = {
			corner_radius = 5,
			drawing = "on",
			border_width = 1,
			border_color = colors.TEXT_WHITE,
			height = 23,
			padding_right = 5,
			padding_left = 5,
		},
		icon = {
			string = sid,
			shadow = { drawing = "off" },
			padding_left = 10,
		},
		label = {
			font = "sketchybar-app-font:Regular:16.0",
			padding_right = 20,
			padding_left = 0,
			y_offset = -1,
			shadow = { drawing = "off" },
		},
		click_script = "aerospace workspace " .. sid,
	})

	workspace_states[sid] = {
		drawing = "off",
		label_string = "",
		icon_color = colors.TEXT_GREY,
	}
end

-- Helper function to check if two states are equal
local function states_equal(old, new)
	if (old == nil) ~= (new == nil) then
		return false
	end
	if old == nil then
		return true
	end

	return old.drawing == new.drawing and old.label_string == new.label_string and old.icon_color == new.icon_color
end

-- Build partial current state from aerospace (only non-empty workspaces)
local function build_current_state()
	local state = {}
	local focused_workspace = exec("aerospace list-workspaces --focused")

	-- Only build state for non-empty workspaces
	local monitors = exec_lines("aerospace list-monitors")
	for i, _ in ipairs(monitors) do
		local non_empty_workspaces = exec_lines("aerospace list-workspaces --monitor " .. i .. " --empty no")

		for _, sid in ipairs(non_empty_workspaces) do
			local apps_raw = exec(string.format("aerospace list-windows --workspace %s", sid))

			local icon_strip = " "
			for line in apps_raw:gmatch("[^\r\n]+") do
				local app_name = line:match("|%s*(.-)%s*|")
				if app_name then
					icon_strip = icon_strip .. " " .. icon_map(app_name)
				end
			end

			state[sid] = {
				drawing = "on",
				label_string = icon_strip,
				icon_color = (sid == focused_workspace) and colors.TEXT_WHITE or colors.TEXT_GREY,
			}
		end
	end

	return state
end

-- Function to update all workspace states (with diff-based optimization)
local function update_all_workspaces()
	sbar.begin_config()
	-- Build partial state from aerospace (only non-empty workspaces)
	local new_state = build_current_state()

	-- Move empty workspaces to monitor 1 (side effect)
	local empty_workspaces = exec_lines("aerospace list-workspaces --all --empty yes")
	for _, sid in ipairs(empty_workspaces) do
		-- WARN: this assumes monitor 1 is your main monitor
		os.execute(string.format("aerospace move-workspace-to-monitor --workspace %s 1", sid))
	end

	-- Loop through all workspaces to handle both non-empty and empty cases
	for _, sid in ipairs(all_workspaces) do
		local old_ws_state = workspace_states[sid]
		local new_ws_state = new_state[sid]

		if new_ws_state == nil then
			-- Workspace became or stayed empty
			if old_ws_state.drawing == "on" then
				-- Was visible, now hide it
				sbar.set("space." .. sid, {
					drawing = "off",
					label = { string = "", color = colors.TEXT_GREY },
					icon = { color = colors.TEXT_GREY },
					background = {
						color = colors.TRANSPARENT,
						border_color = colors.TEXT_WHITE,
					},
				})

				-- Reset to empty state
				workspace_states[sid].drawing = "off"
				workspace_states[sid].label_string = ""
				workspace_states[sid].icon_color = colors.TEXT_GREY
			end
		else
			-- Workspace is non-empty, check if state changed
			if not states_equal(old_ws_state, new_ws_state) then
				local is_focused = (new_ws_state.icon_color == colors.TEXT_WHITE)

				sbar.set("space." .. sid, {
					drawing = new_ws_state.drawing,
					label = {
						string = new_ws_state.label_string,
						color = is_focused and colors.TEXT_WHITE or colors.TEXT_GREY,
					},
					icon = { color = new_ws_state.icon_color },
					background = {
						color = is_focused and colors.HIGHLIGHT_BACKGROUND or colors.TRANSPARENT,
						border_color = is_focused and colors.TEXT_GREY or colors.TEXT_WHITE,
					},
				})

				workspace_states[sid] = new_ws_state
			end
		end
	end
	sbar.end_config()
end

-- Load icons on startup for non-empty workspaces
update_all_workspaces()

-- Create space separator that handles events
local poop = sbar.add("item", "poop", {
	position = "q",
	icon = { string = "💩", padding_left = 20, padding_right = 0, margin_right = 0 },
	label = { drawing = "off", padding_left = 0, margin_left = 0 },
	background = { drawing = "off" },
})

-- Subscribe to aerospace events
poop:subscribe("aerospace_workspace_change", function(env)
	update_all_workspaces()
end)

poop:subscribe("space_windows_change", function(env)
	update_all_workspaces()
end)

poop:subscribe("front_app_switched", function(env)
	update_all_workspaces()
end)

poop:subscribe("aerospace_monitor_change", function(env)
	if env.FOCUSED_WORKSPACE and env.TARGET_MONITOR then
		sbar.set("space." .. env.FOCUSED_WORKSPACE, {
			display = env.TARGET_MONITOR,
		})
	end
end)

-- Create spaces bracket
local space_names = {}
for _, sid in ipairs(all_workspaces) do
	table.insert(space_names, "space." .. sid)
end

sbar.add("bracket", "spaces", space_names, {
	background = {
		color = colors.BACKGROUND,
		corner_radius = 10,
		height = 30,
	},
})
