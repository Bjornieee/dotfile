--- DEFAULT LIBRARIES ---
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

--- BINDINGS ---
local tasklist_bindings = gears.table.join(
        awful.button({ }, 1, function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal(
                        "request::activate",
                        "tasklist",
                        {raise = true, switchtotag = true,}
                )
            end
        end))

--- TASK ---
task = awful.popup {
    widget = awful.widget.tasklist {
        screen   = screen[1],
        filter   = awful.widget.tasklist.filter.allscreen,
        buttons  = tasklist_bindings,
        style    = {
            shape = gears.shape.partially_rounded_rect,
        },
        widget_template = {
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = 5,
                widget  = wibox.container.margin,
            },
            id              = 'background_role',
            forced_width    = 48,
            forced_height   = 48,
            widget          = wibox.container.background,
            create_callback = function(self, c)
                self:get_children_by_id('clienticon')[1].client = c
            end,

        },
    },
    border_width = 0,
    visible = false,
    ontop = true,
    placement    = awful.placement.centered,
    shape        = gears.shape.partially_rounded_rect

}
return task