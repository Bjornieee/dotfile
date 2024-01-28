--- DEFAULT LIBRARIES ---
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

--- TAGS ---
awful.tag({ "  ", "  ", "  ", "  ", "  ", " 󰊴 ", " 󰄘 "}, screen[1], awful.layout.suit.spiral)

--- TAGLIST ---
taglist = awful.widget.taglist {
        screen  = screen[1],
        filter  = awful.widget.taglist.filter.all,
        style   = {
            shape = gears.shape.powerline
        },
        layout   = {
            spacing = -12,
            spacing_widget = {
                color  = beautiful.white,
                shape  = gears.shape.powerline,
                widget = wibox.widget.separator,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 30,
                right = 36,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }

return taglist
