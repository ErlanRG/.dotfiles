-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 3,

		border_size = 1,

		col = {
			active_border = { colors = { "rgba(a6e3a1ee)", "rgba(89b4faee)" }, angle = 45 },
			inactive_border = "rgba(6c7086aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "master",
	},

	decoration = {
		rounding = 8,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 4,
			passes = 3,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.curve("smoothOut", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("swift", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("workspaceMove", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

hl.curve("snappy", { type = "spring", mass = 1, stiffness = 85, dampening = 11 })
hl.curve("floaty", { type = "spring", mass = 0.8, stiffness = 65, dampening = 10 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "smoothOut" })

hl.animation({ leaf = "windows", enabled = true, speed = 5, spring = "snappy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, spring = "floaty", style = "popin 88%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "swift", style = "popin 86%" })

hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "smoothOut" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.8, bezier = "smoothOut" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "swift" })

hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "overshot" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "swift", style = "fade" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 3.5, bezier = "workspaceMove", style = "slidefade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3, bezier = "workspaceMove", style = "slidefade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.5, bezier = "swift", style = "slidefade" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "swift" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true,
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		mfact = 0.5,
		new_status = "master",
		orientation = "center",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})
