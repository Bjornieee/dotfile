--- DEFAULT LIBRARIES ---
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

--- VARIABLES ---
local HOME = os.getenv('HOME')
local ICON_DIR = HOME .. '/.config/awesome/icons/logout/'

--- WIDGET ---
local logout_menu_widget = wibox.widget {
    {
        {
            image = ICON_DIR .. 'power_w.svg',
            resize = true,
            widget = wibox.widget.imagebox,
        },
        margins = 4,
        layout = wibox.container.margin
    },
    widget = wibox.container.background,
}

--- LOGOUT MENU ---
local popup = awful.popup {
    ontop = true,
    visible = false,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,
    border_width = 2,
    opacity = 0.9,
    border_color = "#00000000",
    maximum_width = 400,
    offset = { y = 5 },
    widget = {}
}

--- INTERACTION FUNCTION ---
local function worker()
    local rows = { layout = wibox.layout.fixed.vertical }
    local onlogout = function () awesome.quit() end
    local onreboot = function() awful.spawn.with_shell("reboot") end
    local onpoweroff = function() awful.spawn.with_shell("shutdown now") end

    local menu_items = {
        { name = 'Log out', icon_name = 'log-out.svg', command = onlogout },
        { name = 'Reboot', icon_name = 'refresh-cw.svg', command = onreboot },
        { name = 'Power off', icon_name = 'power.svg', command = onpoweroff },
    }
    for _, item in ipairs(menu_items) do
        local row = wibox.widget {
            {
                {
                    {
                        image = ICON_DIR .. item.icon_name,
                        resize = false,
                        widget = wibox.widget.imagebox
                    },
                    {
                        text = item.name,
                        widget = wibox.widget.textbox
                    },
                    spacing = 12,
                    layout = wibox.layout.fixed.horizontal
                },
                margins = 8,
                layout = wibox.container.margin
            },
            bg = beautiful.bg_normal,
            widget = wibox.container.background
        }

        row:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_focus) end)
        row:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)


        row:buttons(awful.util.table.join(awful.button({}, 1, function()
            popup.visible = not popup.visible
            item.command()
        end)))

        table.insert(rows, row)
    end
    popup:setup(rows)

    logout_menu_widget:buttons(
            awful.util.table.join(
                    awful.button({}, 1, function()
                        if popup.visible then
                            popup.visible = not popup.visible
                            logout_menu_widget:set_bg('#00000000')
                        else
                            popup:move_next_to(mouse.current_widget_geometry)
                            logout_menu_widget:set_bg(beautiful.bg_focus)
                        end
                    end)
            )
    )

    return logout_menu_widget
end
return worker