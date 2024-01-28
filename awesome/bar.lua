--- DEFAULT LIBRARIES ---
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")

--- CUSTOM LIBRARIES ---
local logout_menu_widget = require("logout_menu")
local taglist = require("taglist")
local calendar = require("calendar")
local battery = require("batteryarc")

local mytextclock = wibox.widget.textclock()

--- BAR ---
bar = awful.wibar({ position = "top", screen = screen[1], opacity = 0.65, fg = beautiful.white, height = 25})
bar:setup {
    layout = wibox.layout.align.horizontal,
    {
        layout = wibox.layout.fixed.horizontal,
        taglist,
    },
    mytasklist, -- Middle widget / only here for gap
    {
        layout = wibox.layout.fixed.horizontal,
        spacing = 5,
        battery,
        mytextclock,
        logout_menu_widget(),
    },
}
calendar:attach(mytextclock, "tr")
return bar
