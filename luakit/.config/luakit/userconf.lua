-- Settings (the commented ones do not [yet] work)
local settings = require "settings"

settings.window.home_page                             = "about:blank"
settings.window.scroll_step                           = 60
settings.window.zoom_step                             = 0.2
settings.window.new_window_size                       = "1366x768"
settings.window.load_etc_hosts                        = false
-- settings.vertical_tabs.sidebar_width                  = 200

settings.webview.zoom_level                           = 120
settings.webview.zoom_text_only                       = true
settings.webview.enable_webgl                         = true

settings.on["youtube.com"].webview.enable_javascript  = true
settings.on["youtube.com"].webview.enable_plugins     = true

settings.window.search_engines.archwiki               = "https://wiki.archlinux.org/?search=%s"
settings.window.search_engines.aur                    = "https://aur.archlinux.org/packages.php?O=0&K=%s&do_Search=Go"
settings.window.search_engines.duckduckgo             = "https://duckduckgo.com/?q=%s"
settings.window.search_engines.github                 = "https://github.com/search?q=%s"
settings.window.search_engines.google                 = "https://google.com/search?q=%s"
settings.window.search_engines.imdb                   = "http://www.imdb.com/find?s=all&q=%s"
settings.window.search_engines.ncbi                   = "https://www.ncbi.nlm.nih.gov/gquery/?term=%s"
settings.window.search_engines.wikipedia              = "https://en.wikipedia.org/wiki/Special:Search?search=%s"

settings.window.search_engines.default                = settings.window.search_engines.google

