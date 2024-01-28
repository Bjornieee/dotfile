--- DEFAULT LIBRARIES ---
local gears = require("gears")
local awful = require("awful")

--- CUSTOM LIBRARIES ---
local scratch = require("scratch")
local task = require("task")

--- VARIABLES ---
local modkey = "Mod4"
bindings = {}

--- KEYBOARD BINDINGS ---
    bindings.keyboard = {
        client = gears.table.join(
                awful.key({ modkey, }, "f",
                        function(c)
                            c.fullscreen = not c.fullscreen
                            c:raise()
                        end),

                awful.key({ modkey, "Shift" }, "a", function(c)
                    c:kill()
                end),

                awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),

                awful.key({ modkey, }, "n",
                        function(c)
                            c.minimized = true
                        end)

        ),

    global = gears.table.join(
                awful.key({ modkey,           }, "s", function () scratch.toggle(discord,{ class = "discord" })
                end ),

                awful.key({ modkey,           }, "Tab", awful.tag.history.restore),

                awful.key({ modkey,           }, "Right",
                        function ()
                            awful.client.focus.byidx(1)
                        end
                ),

                awful.key({ modkey,           }, "Left",
                        function ()
                            awful.client.focus.byidx(-1)
                        end
                ),

                awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx(1)
                end ),

                awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx(-1)
                end ),

                awful.key({ modkey,           }, "Escape",
                        function ()
                            if task.visible then
                                task.visible = false
                            else
                                task.visible = true
                            end
                        end ),

                awful.key({ modkey,           }, "Return",
                        function () scratch.toggle(terminal,{ class = "kitty" })
                        end
                ),

                awful.key({ modkey, "Control" }, "r", awesome.restart),

                awful.key({ modkey, "Shift"   }, "q", awesome.quit),

                awful.key({ modkey }, "d", function () awful.spawn.with_shell("rofi -show drun")
                end )
        ),}

    for i = 1, 9 do
        bindings.keyboard = {
            client = gears.table.join(bindings.keyboard.client
            ),
            global = gears.table.join(bindings.keyboard.global,
                    awful.key({ modkey }, "#" .. i + 9,
                            function ()
                                local screen = awful.screen.focused()
                                local tag = screen.tags[i]
                                if tag then
                                    if tag~=screen.selected_tag then
                                        awful.spawn.with_shell("nitrogen --random --set-tiled")
                                    end
                                    tag:view_only()
                                end
                            end,
                            {description = "view tag #"..i, group = "tag"}),

                    awful.key({ modkey, "Control" }, "#" .. i + 9,
                            function ()
                                local screen = awful.screen.focused()
                                local tag = screen.tags[i]
                                if tag then
                                    awful.tag.viewtoggle(tag)
                                end
                            end,
                            {description = "toggle tag #" .. i, group = "tag"}),

                    awful.key({ modkey, "Shift" }, "#" .. i + 9,
                            function ()
                                if client.focus then
                                    local tag = client.focus.screen.tags[i]
                                    if tag then
                                        client.focus:move_to_tag(tag)
                                    end
                                end
                            end,
                            {description = "move focused client to tag #"..i, group = "tag"}),

                    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                            function ()
                                if client.focus then
                                    local tag = client.focus.screen.tags[i]
                                    if tag then
                                        client.focus:toggle_tag(tag)
                                    end
                                end
                            end,
                            {description = "toggle focused client on tag #" .. i, group = "tag"})
            )
        }
end

--- MOUSE BINDINGS ---
bindings.mouse = {
    client = gears.table.join(
            awful.button({ }, 1, function(c)
                c:emit_signal("request::activate", "mouse_click", { raise = true })
            end),
            awful.button({ modkey }, 3, function(c)
                c:emit_signal("request::activate", "mouse_click", { raise = true })
                awful.mouse.client.move(c)
            end),
            awful.button({ modkey }, 1, function(c)
                c:emit_signal("request::activate", "mouse_click", { raise = true })
                awful.mouse.client.resize(c)
            end)
    )}

return bindings