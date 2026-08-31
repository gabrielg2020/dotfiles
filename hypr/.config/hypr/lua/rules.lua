-- See https://wiki.hypr.land/Configuring/Workspace-Rules/
-- and https://wiki.hypr.land/Configuring/Window-Rules/

-- Workspaces 1-5 on main monitor (DP-1), 6-10 on second monitor (HDMI-A-2)
for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1", default = (i == 1) })
end
for i = 6, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-2", default = (i == 6) })
end

-- "Smart gaps" / "No gaps when only" — lone windows sit truly edge-to-edge
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
hl.window_rule({
    name  = "no-gaps-wtv1",
    match = { float = false, workspace = "w[tv1]" },
    border_size = 0,
    rounding    = 0,
})
hl.window_rule({
    name  = "no-gaps-f1",
    match = { float = false, workspace = "f[1]" },
    border_size = 0,
    rounding    = 0,
})

-- Ignore maximize requests from all apps
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- Apps that live on the second monitor
hl.window_rule({ name = "discord-ws6", match = { class = "discord" }, workspace = "6" })
hl.window_rule({ name = "spotify-ws7", match = { class = "Spotify" }, workspace = "7" })
