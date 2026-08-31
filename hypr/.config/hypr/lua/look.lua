-- See https://wiki.hypr.land/Configuring/Variables/

hl.config({
    general = {
        gaps_in     = 2,
        gaps_out    = 4,
        border_size = 1,

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 12,
            render_power = 3,
            offset       = { 0, 4 },
        },

        blur = {
            enabled           = true,
            size              = 8,
            passes            = 3,
            ignore_opacity    = true,
            new_optimizations = true,
            vibrancy          = 0.2,
            vibrancy_darkness = 0.3,
            noise             = 0.02,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,    -- Disable anime mascot wallpapers
        disable_hyprland_logo   = true, -- Disable hyprland logo background
        vrr                     = 0,    -- Disable variable refresh rate
    },

    debug = {
        vfr = false, -- Disable VFR - can cause artifacts with mismatched refresh rates
    },
})

-- Nearly instant animations for a snappy feel
hl.curve("instant", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

for _, leaf in ipairs({
    "windows", "windowsIn", "windowsOut", "windowsMove",
    "border", "fade", "fadeIn", "fadeOut",
    "workspaces", "specialWorkspace",
}) do
    hl.animation({ leaf = leaf, enabled = true, speed = 1, bezier = "instant" })
end
