--- @see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
---- APPS ----
local fileManager = "ghostty -e yazi"
local browser = "zen-browser"
local mod = "SUPER"
local menu = "wofi"
local terminal = "ghostty -e tmux"
local screenlayoutPath = "~/.config/screenlayout/applet.sh"

-- Focus & window movement
local directions = {
	left = { arrow = "left", vimKey = "H" },
	down = { arrow = "down", vimKey = "J" },
	up = { arrow = "up", vimKey = "K" },
	right = { arrow = "right", vimKey = "L" },
}

for direction, keys in pairs(directions) do
	-- Focus movement
	hl.bind(mod .. " + " .. keys.arrow, hl.dsp.focus({ direction = direction }))
	hl.bind(mod .. " + " .. keys.vimKey, hl.dsp.focus({ direction = direction }))

	-- Window movement
	hl.bind(mod .. " + SHIFT + " .. keys.arrow, hl.dsp.window.move({ direction = direction }))
	hl.bind(mod .. " + SHIFT + " .. keys.vimKey, hl.dsp.window.move({ direction = direction }))
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("ALT + TAB", hl.dsp.focus({ last = true }))
hl.bind(mod .. " + ALT + L", hl.dsp.exec_cmd("swaylock"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + N", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + SHIFT + P", hl.dsp.exec_cmd(screenlayoutPath))
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload && notify-send 'Reloading Hyprland config...'"))
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))

-- Fullscreen
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mod .. " +SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Example special workspace (scratchpad)
hl.bind(mod .. " + I", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + I", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- hl.bind(
-- 	mod .. " + M",
-- 	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
-- )
