--- DEFAULT LIBRARIES ---
local xresources = require("beautiful.xresources")

--- VARIABLES ---
local dpi = xresources.apply_dpi
local theme = {}

--- PALETTE ---
theme.red           = "#BF616A"
theme.orange        = "#D08770"
theme.yellow        = "#EBCB8B"
theme.green         = "#A3BE8C"
theme.purple        = "#B48EAD"
theme.darkBlue      = "#5E81AC"
theme.lightBlue     = "#81A1C1"
theme.cyan          = "#88C0D0"
theme.turquoise     = "#8FBCBB"
theme.grey          = "#D8DEE9"
theme.lightGrey     = "#E5E9F0"
theme.white         = "#ECEFF4"
theme.darkestBlack  = "#2E3440"
theme.darkBlack     = "#3B4252"
theme.lightBlack    = "#434C5E"
theme.lightestBlack = "#4C566A"

--- THEME COLORS ---
theme.bg_normal     = theme.darkestBlack
theme.bg_focus      = theme.lightestBlack
theme.bg_urgent     = theme.red
theme.bg_minimize   = theme.grey
theme.bg_systray    = theme.darkestBlack
theme.fg_normal     = theme.grey
theme.fg_focus      = theme.white
theme.fg_urgent     = theme.white
theme.fg_minimize   = theme.white
theme.useless_gap   = dpi(10)
theme.border_width  = dpi(3)
theme.border_normal = theme.darkBlue
theme.border_focus  = theme.lightBlue
theme.border_marked = theme.red


-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]


-- You can use your own layout icons like this:
-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
