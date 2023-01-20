--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "Roboto Condensed, Regular 14px"
theme.fg   = "#000"
theme.bg   = "#D3D3D3"

-- Genaral colours
theme.success_fg = "#0f0"
theme.loaded_fg  = "#0000CC"
theme.error_fg   = "#FFF"
theme.error_bg   = "#F00"

-- Warning colours
theme.warning_fg = "#F00"
theme.warning_bg = "#FFF"

-- Notification colours
theme.notif_fg = "#444"
theme.notif_bg = "#FFF"

-- Menu colours
theme.menu_fg                   = "#000"
theme.menu_bg                   = "#fff"
theme.menu_selected_fg          = "#000"
theme.menu_selected_bg          = "#FF0"
theme.menu_title_bg             = "#fff"
theme.menu_primary_title_fg     = "#f00"
theme.menu_secondary_title_fg   = "#666"

theme.menu_disabled_fg = "#999"
theme.menu_disabled_bg = theme.menu_bg
theme.menu_enabled_fg  = theme.menu_fg
theme.menu_enabled_bg  = theme.menu_bg
theme.menu_active_fg   = "#060"
theme.menu_active_bg   = theme.menu_bg

-- Proxy manager
theme.proxy_active_menu_fg      = '#000'
theme.proxy_active_menu_bg      = '#FFF'
theme.proxy_inactive_menu_fg    = '#888'
theme.proxy_inactive_menu_bg    = '#FFF'

-- Statusbar specific
theme.sbar_fg         = theme.fg
theme.sbar_bg         = theme.bg

-- Downloadbar specific
theme.dbar_fg         = "#fff"
theme.dbar_bg         = "#000"
theme.dbar_error_fg   = "#F00"

-- Input bar specific
theme.ibar_fg           = "#fff"
theme.ibar_bg           = "rgba(22,22,22,.90)"

-- Tab label
theme.tab_fg            = "#888"
theme.tab_bg            = "rgba(22,22,22,.80)"
theme.tab_hover_bg      = "rgba(0,0,0,0.1)"
theme.tab_ntheme        = "#ddd"
theme.selected_fg       = theme.fg
theme.selected_bg       = theme.bg
theme.selected_ntheme   = "#009900"
theme.loading_fg        = "#33AADD"
theme.loading_bg        = "#fff"

theme.selected_private_tab_bg = "#3d295b"
theme.private_tab_bg          = "#22254a"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#009900"
theme.notrust_fg        = "#990000"

-- General colour pairings
theme.ok = { fg = "#fff", bg = "#FFF" }      -- Change back first to #000 for black in pattern searches
theme.warn = { fg = "#F00", bg = "#FFF" }
theme.error = { fg = "#DB0", bg = "#F00" }   -- Change back first to #FFF for white in pattern searches

return theme

-- vim: et:sw=4:ts=8:sts=4:tw=80
