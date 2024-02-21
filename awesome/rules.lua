--- DEFAULT LIBRARIES ---
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

--- CUSTOM LIBRARIES ---
local bindings = require("bindings")

--- VARIABLES ---
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

---
beautiful.init("/home/haissam/.config/awesome/theme.lua")

---
awful.rules.rules = {
--- ALL INSTANCES RULES ---
    { rule = {},
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = bindings.keyboard.client,
                     buttons = bindings.mouse.client,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap + awful.placement.no_offscreen,
                     beautiful.gap_single_client,
      }
    },

--- SCRATCHPAD RULES ---
    { rule_any = {class = {"discord", "kitty"}},
      instance = { "scratch" },
      properties = { skip_taskbar = true, titlebars_enabled = false, floating = true, ontop = true, minimized = true,
                     sticky = true, width = screen_width * 0.65, height = screen_height * 0.65
      },
      callback = function (c)
          awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
          gears.timer.delayed_call(function()
              c.urgent = false
              c.border_width = 1
          end)
      end
    },

--- TAGS RULES ---
    {rule_any = {class = {"termite"}},
     properties = {tag = "  ", skip_taskbar = true, titlebars_enabled = false, urgent = false, },
    },

    {rule_any = {class =  {"jetbrains-clion", "Code", "jetbrains-pycharm", "jetbrains-idea", "jetbrains-datagrip"}},
     properties = { tag = "  ", switchtotag = true },
    },

    {rule_any = {class = {"Google-chrome"}},
     properties = { tag = "  ", switchtotag = true },
    },

    {rule_any = {class = {"Anydesk", "anydesk"}},
     properties = { tag = " 󰄘 " , switchtotag = false},
    },

    {rule_any = {class = {"Font-manager", "Thunar"}},
     properties = { tag = "  " , switchtotag = false},
    },

    {rule_any = {class = {"VirtualBox Manager", "VirtualBox Machine"}},
     properties = { tag = "  " , switchtotag = true, fullscreen = true},
    },

    {rule_any = {class = {"steam", "steam_app_1449850", "league of legends.exe", "Lutris", "leagueclientux.exe", "leagueclient.exe"}},
     properties = { tag = " 󰊴 " , switchtotag = true},
    },

--- GAMES ---
    { rule_any = {class = {"explorer.exe"}},
    properties = {hidden = true, tag = " 󰊴 ", urgent = false}
    },

    {rule_any = {class = {"leagueclient.exe"},
    properties = {border_width = 0,}}
    },

    {rule_any = {class = {"league of legends.exe"},
             properties = {border_width = 0, gap_single_client = false}}
    },
}

return awful.rules.rules