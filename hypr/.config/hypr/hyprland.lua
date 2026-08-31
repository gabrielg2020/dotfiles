-- Hyprland config (Lua, 0.55+). Split into modules — each require() is an
-- isolated scope, so an error in one file does not take the rest down.
-- https://wiki.hypr.land/Configuring/

require("lua.monitors")
require("lua.env")
require("lua.autostart")
require("lua.look")
require("lua.input")
require("lua.rules")
require("lua.binds")

-- Theme colours. Switch by changing the require:
-- - themes.noir
require("themes.noir")
