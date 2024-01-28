--- DEFAULT LIBRARIES ---
local awful = require("awful")

--- THEME ---
local beautiful = require("beautiful")
beautiful.init("/home/haissam/.config/awesome/theme.lua")
awful.layout.layouts = { awful.layout.suit.spiral }

--- RULES ---
require("rules")

--- BINDINGS ---
local bindings = require("bindings")
root.keys(bindings.keyboard.global)
root.buttons(bindings.mouse.client)



--- AUTOFOCUS ---
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false}) end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

--- BAR ---
require("bar")

--- AUTOSTART ---
require("autostart")

--- DASHBOARD ---
---require("dashboard.init")
