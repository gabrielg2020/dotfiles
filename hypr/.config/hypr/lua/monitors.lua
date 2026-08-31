-- See https://wiki.hypr.land/Configuring/Monitors/

-- 2560x1440 @ 165Hz (left monitor, primary)
hl.monitor({ output = "DP-1",     mode = "2560x1440@165.00", position = "0x0",    scale = 1 })
-- 1920x1080 @ 100Hz (right monitor)
hl.monitor({ output = "HDMI-A-2", mode = "1920x1080@100.00", position = "2560x0", scale = 1 })
