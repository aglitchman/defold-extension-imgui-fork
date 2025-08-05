local values_line = {}
local values_hist = {}

local show_live_data = false

local function make_data()
	values_line = {}
	values_hist = {}
	for i=1, 60 do 
		local data = math.random(1, 30)
		values_hist[data] = (values_hist[data] or 0) + 1
		table.insert(values_line, data)
	end
end

make_data()

return function(self)
	local changed, checked = imgui.checkbox("Live Data", show_live_data)
	if changed then
		show_live_data = checked
	end

	if show_live_data == true then 
		make_data()
	end
	imgui.separator()

	imgui.text_colored(" Data Plot ", 1, 0, 0, 1 )
	imgui.plot_lines( "Data", 0, 150, 40, values_line )

	imgui.separator()

	imgui.text_colored(" Data Histogram ", 0, 1, 0, 1 )
	imgui.plot_histogram( "Histogram", 0, 150, 40, values_hist )

	imgui.separator()

	-- Curve Editor Example
	imgui.text_colored(" Curve Editor ", 0, 0, 1, 1 )
	
	-- Initialize curve data if not exists
	if not self.curve_points then
		self.curve_points = {
			-- new Keyframe(750f, .6f), new Keyframe(4000f, 1f), new Keyframe(7000f, .85f)
			vmath.vector3(750.0, 0.7, 0.0),
			vmath.vector3(4000.0, 1, 0.0),
			vmath.vector3(7000.0, 0.85, 0.0)
		}
		self.curve_selection = nil
		self.curve_range = {
			min = vmath.vector3(750.0, 0.7, 0),
			max = vmath.vector3(7000.0, 1.0, 0)
		}
	end

	-- Curve editor widget
	local changed, new_points, new_selection = imgui.curve(
		"Curve", 
		400, 150,           -- width, height
		10,                 -- max points
		self.curve_points, 
		self.curve_selection,
		self.curve_range.min,
		self.curve_range.max
	)

	if changed then
		print(changed, #new_points, new_selection)
		self.curve_points = new_points
		self.curve_selection = new_selection
	end

	-- Show curve values at different positions
	imgui.text("Sample curve values:")
	local positions = {0.0, 0.25, 0.5, 0.75, 1.0}
	for _, pos in ipairs(positions) do
		local value = imgui.curve_value(pos, self.curve_points)
		local smooth_value = imgui.curve_value_smooth(pos, self.curve_points)
		imgui.text(string.format("  t=%.2f: value=%.3f, smooth=%.3f", pos, value, smooth_value))
	end
end
