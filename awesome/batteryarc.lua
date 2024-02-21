--- DEFAULT LIBRARIES ---
local wibox = require("wibox")
local watch = require("awful.widget.watch")

--- VARIABLES ---
local HOME = os.getenv('HOME')
local ICON_DIR = HOME .. '/.config/awesome/icons/bar/'
local batteryarc_widget = {}
local icon = wibox.widget {
    image = ICON_DIR .. 'battery.svg',
    resize = true,
    widget = wibox.widget.imagebox
}

--- WIDGET ---
batteryarc_widget = wibox.widget {
    icon,
    max_value = 100,
    rounded_edge = true,
    thickness = 3,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 20,
    forced_width = 20,
    paddings = 2,
    widget = wibox.container.arcchart
}

local function update_widget(widget, stdout)
    local charge = 0
    local status
    for s in stdout:gmatch("[^\r\n]+") do
        local cur_status, charge_str, _ = string.match(s, '.+: ([%a%s]+), (%d?%d?%d)%%,?(.*)')
        if cur_status and charge_str then
             local cur_charge = tonumber(charge_str)
             if cur_charge > charge then
                  status = cur_status
                  charge = cur_charge
             end
        end
    end
    widget.value = charge
end

watch("acpi", 10, update_widget, batteryarc_widget)
return batteryarc_widget

