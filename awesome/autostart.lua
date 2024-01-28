--- DEFAULT LIBRARIES ---
local awful = require("awful")

---AUTOSTART ---
autostart = {

    awful.spawn.once("discord", { { class = "discord" }, instance = { "scratch" }, hidden = true, raise = false }),
    awful.spawn.single_instance("picom"),
    awful.spawn.single_instance("nitrogen --random --set-tiled"),
    awful.spawn.with_shell("killall -q kitty & sleep 1 && kitty --class termite -e 'cmatrix' & sleep 1.5 && kitty --class termite -e btop & sleep 2 && kitty --class termite -e lf"),
    awful.spawn.once("anydesk", { hidden = true }),
    awful.spawn.single_instance("kitty", { { class = "kitty" }, instance = { "scratch" }, hidden = true, raise = false }),

}
return autostart