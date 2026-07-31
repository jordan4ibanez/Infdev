package src.engine.player;

import src.engine.vector.Vec2;

// Will only be present if the client sent this information (requires v5.7+)
//
// Note that none of these things are constant, they are likely to change during a client
// connection as the player resizes the window and moves it between monitors
//
// real_gui_scaling and real_hud_scaling can be used instead of DPI.
// OSes don't necessarily give the physical DPI, as they may allow user configuration.
// real_*_scaling is just OS DPI / 96 but with another level of user configuration.
typedef PlayerWindowInformation = {
	// Current size of the in-game render target (pixels).
	//
	// This is usually the window size, but may be smaller in certain situations,
	// such as side-by-side mode.
	var size: Vec2;

	// Estimated maximum formspec size before Luanti will start shrinking the
	// formspec to fit. For a fullscreen formspec, use the size returned by
	// this table  and `padding[0,0]`. `bgcolor[;true]` is also recommended.
	var max_formspec_size: Vec2;

	// GUI Scaling multiplier
	// Equal to the setting `gui_scaling` multiplied by `dpi / 96`
	var real_gui_scaling: Float;

	// HUD Scaling multiplier
	// Equal to the setting `hud_scaling` multiplied by `dpi / 96`
	var real_hud_scaling: Float;

	// Whether the touchscreen controls are enabled.
	// Usually (but not always) `true` on Android.
	// Requires at least version 5.9.0 on the client. For older clients, it
	// is always set to `false`.
	var touch_controls: Bool;
}
