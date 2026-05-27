-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- Floating apps (centered) - by class
hl.window_rule({
	name = "floating-apps-centered",
	match = {
		class = "^(org.keepassxc.KeePassXC|org.cachyos.hello|org.pulseaudio.pavucontrol|solaar|qalculate-gtk|com.nextcloud.desktopclient.nextcloud)$",
	},
	float = true,
	center = true,
})

-- Floating apps (centered) - by title
hl.window_rule({
	name = "floating-apps-centered-by-title",
	match = {
		title = "^(Picture-in-Picture|KeePassXC - Passkey credentials|Friends List)$",
	},
	float = true,
	center = true,
})

-- Floating apps size to 1920x1080
hl.window_rule({
	name = "floating-size-hd",
	match = {
		class = "^(org.keepassxc.KeePassXC|org.cachyos.hello|org.pulseaudio.pavucontrol|solaar)$",
	},
	float = true,
	size = { "1920", "1080" },
})

-- Floating apps size to 640x480
hl.window_rule({
	name = "floating-size-passkey",
	match = {
		class = "^(org.keepassxc.KeePassXC)$",
		title = "^(KeePassXC - Passkey credentials)$",
	},
	size = { "640", "480" },
})

hl.window_rule({
	name = "floating-size-nextcloud",
	match = {
		class = "^(com.nextcloud.desktopclient.nextcloud)$",
	},
	size = { "640", "480" },
})

-- Floating apps size to minimum values - qalculate-gtk
hl.window_rule({
	name = "floating-size-min-qalculate",
	match = {
		class = "^(qalculate-gtk)$",
	},
	size = { "1", "1" },
})

-- -- Send RuneScape and BoltLauncher to workspace/tag 4
hl.window_rule({
	name = "send-to-tag-4",
	match = {
		class = "^(RuneScape|BoltLauncher)$",
	},
	workspace = "4",
})

-- Block apps on screenshare
hl.window_rule({
	name = "block-on-screenshare",
	match = { class = "^(org.keepassxc.KeePassXC)$" },
	no_screen_share = true,
})

hl.window_rule({
	name = "ignore-blur",
	match = { class = "^(com.mitchellh.ghostty)$" },
	opacity = "0.95 0.90 override",
})

-- Enable blur and ignore_alpha for rofi
hl.layer_rule({
	match = { namespace = "wofi" },
	blur = true,
	ignore_alpha = 0.5,
})
