-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "DP-1",
	mode = "3440x1440@164.89",
	position = "auto",
	scale = 1,
})

hl.monitor({
	output = "HDMI-A-1",
	-- mode = "2560x1440@59.95Hz",
	-- position = "auto-right",
	-- scale = 1,
	disabled = true,
})
