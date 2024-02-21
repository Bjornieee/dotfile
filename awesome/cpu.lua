local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")

local CMD = [[grep --max-count=1 '^cpu.' /proc/stat]]
local cpu_widget = {}


    local width = 50
    local step_width = 2
    local step_spacing =  1
    local background_color =  "#00000000"
    local timeout = 1

    local cpugraph_widget = wibox.widget {
        max_value = 100,
        background_color = background_color,
        forced_width = width,
        step_width = step_width,
        step_spacing = step_spacing,
        widget = wibox.widget.graph,
        color = "linear:0,0:0,20:0," .. beautiful.red .. ":0.5,".. beautiful.yellow .. ":0.9," .. beautiful.green
    }

    cpugraph_widget:buttons(
            awful.util.table.join(
                    awful.button({}, 1, function()
                        if popup.visible then
                            popup.visible = not popup.visible
                            -- When the popup is not visible, stop the timer
                            popup_timer:stop()
                        else
                            popup:move_next_to(mouse.current_widget_geometry)
                            -- Restart the timer, when the popup becomes visible
                            -- Emit the signal to start the timer directly and not wait the timeout first
                            popup_timer:start()
                            popup_timer:emit_signal("timeout")
                        end
                    end)
            )
    )

    --- By default graph widget goes from left to right, so we mirror it and push up a bit
    cpu_widget = wibox.widget {
        {
            cpugraph_widget,
            reflection = {horizontal = true},
            layout = wibox.container.mirror
        },
        bottom = 2,
        color = background_color,
        widget = wibox.container.margin
    }

    -- This part runs constantly, also when the popup is closed.
    -- It updates the graph widget in the bar.
    local maincpu = {}
    watch(CMD, timeout, function(widget, stdout)

        local _, user, nice, system, idle, iowait, irq, softirq, steal, _, _ =
        stdout:match('(%w+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)')

        local total = user + nice + system + idle + iowait + irq + softirq + steal

        local diff_idle = idle - tonumber(maincpu['idle_prev'] == nil and 0 or maincpu['idle_prev'])
        local diff_total = total - tonumber(maincpu['total_prev'] == nil and 0 or maincpu['total_prev'])
        local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

        maincpu['total_prev'] = total
        maincpu['idle_prev'] = idle

        widget:add_value(diff_usage)
    end,
            cpugraph_widget
    )
    return cpu_widget