local wibox = require("wibox")
local spawn = require("awful.spawn")
local gears = require("gears")
local beautiful = require("beautiful")
local watch = require("awful.widget.watch")

local function GET_VOLUME_CMD(card, device, mixctrl, value_type)
	return "amixer -c " .. card .. " -D " .. device .. " sget " .. mixctrl .. " " .. value_type
end
local function INC_VOLUME_CMD(card, device, mixctrl, value_type, step)
	return "amixer -c "
		.. card
		.. " -D "
		.. device
		.. " sset "
		.. mixctrl
		.. " "
		.. value_type
		.. " "
		.. step
		.. "%+"
end

local function DEC_VOLUME_CMD(card, device, mixctrl, value_type, step)
	return "amixer -c "
		.. card
		.. " -D "
		.. device
		.. " sset "
		.. mixctrl
		.. " "
		.. value_type
		.. " "
		.. step
		.. "%-"
end
local function TOG_VOLUME_CMD(card, device, mixctrl)
	return "amixer -c " .. card .. " -D " .. device .. " sset " .. mixctrl .. " toggle"
end

local widget_types = {
	icon_and_text = require("icon-and-text-widget")
}
local volume = {}


local function build_main_line(device)
	if device.active_port ~= nil and device.ports[device.active_port] ~= nil then
		return device.properties.device_description .. " · " .. device.ports[device.active_port]
	else
		return device.properties.device_description
	end
end

	local mixer_cmd = "pavucontrol"
	local refresh_rate = 0
	local step =  5
	local card = 1
	local device = "pulse"
	local mixctrl = "Master"
	local value_type = "-M"
	local toggle_cmd = nil

volume.widget = widget_types["icon_and_text"]


	local function update_graphic(widget, stdout)
		local mute = string.match(stdout, "%[(o%D%D?)%]") -- \[(o\D\D?)\] - [on] or [off]
		if mute == "off" then
			widget:mute()
		elseif mute == "on" then
			widget:unmute()
		end
		local volume_level = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)
		volume_level = string.format("% 3d", volume_level)
		widget:set_volume_level(volume_level)
	end

	function volume:inc(s)
		spawn.easy_async(INC_VOLUME_CMD(card, device, mixctrl, value_type, s or step), function(stdout)
			update_graphic(volume.widget, stdout)
		end)
	end

	function volume:dec(s)
		spawn.easy_async(DEC_VOLUME_CMD(card, device, mixctrl, value_type, s or step), function(stdout)
			update_graphic(volume.widget, stdout)
		end)
	end

	function volume:toggle()
		if toggle_cmd == nil then
			spawn.easy_async(TOG_VOLUME_CMD(card, device, mixctrl), function(stdout)
				update_graphic(volume.widget, stdout)
			end)
		else
			spawn.easy_async(toggle_cmd, function(_stdout)
				spawn.easy_async(GET_VOLUME_CMD(card, device, mixctrl, value_type), function(stdout)
					update_graphic(volume.widget, stdout)
				end)
			end)
		end
	end

	function volume:mixer()
		if mixer_cmd then
			spawn.easy_async(mixer_cmd)
		end
	end

	watch(GET_VOLUME_CMD(card, device, mixctrl, value_type), refresh_rate, update_graphic, volume.widget)

	return volume.widget
