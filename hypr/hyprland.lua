hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1
})
hl.monitor({
    output = "DP-1",
    mode = "1920x1080@60",
    position = "1920x0",
    scale = 1
})

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar & easyeffects")
    hl.exec_cmd(wallpaper)
end)

local wallpaper   = "mpvpaper -psf -o 'volume=0 loop' HDMI-A-1 '/home/joyboy/Wallpaper/Disco Project W sound V2.mp4'"
local mainMod     = "SUPER"
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"
local telegram    = "AyuGram"
local browser     = "firefox"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
-- hl.bind(mainMod .. " + Q", hl.dsp.kill(hl.get_active_window()))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(telegram))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("killall .waybar-wrapped"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("waybar"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("woomer"))
-- hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("missioncenter"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(wallpaper))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("pkill .mpvpaper"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + P", hl.dsp.group.toggle({ window = "activewindow"}))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("kitty --start-as=fullscreen --title aq sh -c asciiquarium"))
hl.bind(mainMod .. " + N", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + P", hl.dsp.layout("swapsplit"))
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ window = "activewindow", action = "toggle", mode = "maximized"}))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ window = "activewindow", action = "toggle", mode = "fullscreen"}))
-- hl.bind(mainMod .. " + mouse:272", "movewindow", { mouse = true })
-- hl.bind(mainMod .. " + mouse:273", "resizewindow", { mouse = true })

--audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

--focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

--swap
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

--resize
local d = 40
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = d, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -d, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = d, relative = true}), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -d, relative = true}), { repeating = true })

hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "11", monitor = "DP-1"})
hl.workspace_rule({ workspace = "12", monitor = "HDMI-A-1"})
local key
for i = 1, 10 do
    key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
end
hl.bind(mainMod .. " + A", hl.dsp.focus({ workspace = "12" }))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = "12", follow = false }))

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("PRINT",               hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(" + SHIFT + PRINT",    hl.dsp.exec_cmd("hyprshot -m region"))

hl.bind(mainMod .. " + R", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + S", hl.dsp.window.drag(), { mouse = true })

hl.env("XCURSOR_SIZE", "20")

hl.curve( "myBezier", { type = "bezier", points = { {0.2, 0.985}, {0, 1} } })
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4,
    bezier = "myBezier",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 1.7,
    bezier = "myBezier",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3,
    bezier = "myBezier",
})

hl.config({
    general = {
        col = {
            active_border = { colors = {"rgba(0ca2f0ff)"}},
            inactive_border = { colors = {"rgba(075b8767)"}},
        },
        border_size = 2,
        gaps_in = 2,
        gaps_out = 4,
        allow_tearing = true
    },
    dwindle = {
        preserve_split = true,
    },
    decoration = {
        rounding = 1,
        blur = {
            enabled = true,
            contrast = 1.5,
            size = 3,
            -- variant = "",
            passes = 1,
        },
    },
    input = {
        kb_layout  = "us, ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:alt_shift_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
    animations = {
        enabled = true,
    },
    misc = {
         force_default_wallpaper = 1,
         focus_on_activate = true,
    },
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})
