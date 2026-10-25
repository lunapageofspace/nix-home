local mainMod = "SUPER"

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + M", hl.dsp.window.move({ workspace = "special:minimized" }))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.workspace.toggle_special("minimized"))

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Confirm before logout
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/confirm_logout.sh"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

-- Fullscreen (true fullscreen, hides waybar/gaps)
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Maximize (fills screen, keeps waybar/decorations visible)
-- If this errors as "expected a dispatcher" on reload, swap to the fallback:
-- hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("hyprctl dispatch fullscreen 1"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))

-- Resize by holding mod + right-click drag
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Always-on-top (pins floating window across all workspaces)
hl.bind(mainMod .. " + P", hl.dsp.window.pin())

-- Media keys via Fn+F6/F7/F8
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = false })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = false })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = false })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = false })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = false })

-----------------------
---- SCREENSHOTS ------
-----------------------
hl.bind("Print", hl.dsp.exec_cmd(
    "bash -c 'mkdir -p $HOME/Pictures/Screenshots/$(date +%Y-%m) && HYPRSHOT_DIR=$HOME/Pictures/Screenshots/$(date +%Y-%m) hyprshot -m region -z' "
))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/screenshot.sh full"))
hl.bind(mainMod .. " + ALT + Print", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/screenshot.sh output"))


for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end