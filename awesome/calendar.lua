--- DEFAULT LIBRARIES ---
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

--- CUSTOM FUNCTIONS ---
local function rounded_shape(size)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, size)
    end
end

--- CALENDAR ---
calendar = awful.widget.calendar_popup.month(
        { border_width = 2,
          long_weekdays = true,
          opacity = 0.9,

          style_weekday = { fg_color = beautiful.cyan,
                            bg_color = beautiful.darkestBlack,
                            border_width = 0,
                            markup = function(t) return '<b>' .. t .. '</b>' end,},
          style_month = {padding = 4,
                         bg_color = beautiful.darkestBlack,
                         border_width = 14,
                         shape = rounded_shape(4),
                         border_color = "#00000000"},
          style_normal = { markup = function(t) return t end,
                           shape = rounded_shape(4),
                           border_width = 0,},
          style_focus = { fg_color = beautiful.darkestBlack,
                          bg_color = beautiful.cyan,
                          markup = function(t) return '<b>' .. t .. '</b>' end,
                          shape = rounded_shape(4),
                          border_width = 0,},
          style_header = { fg_color = beautiful.lightGrey,
                           bg_color = beautiful.darkestBlack,
                           markup = function(t) return '<b>' .. t .. '</b>' end,
                           border_width = 0,
          },
        }
)
return calendar