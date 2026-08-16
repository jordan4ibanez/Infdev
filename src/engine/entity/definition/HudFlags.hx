package src.engine.entity.definition;

typedef HudFlags = {
	@:optional
	var hotbar: Bool;
	@:optional
	var healthbar: Bool;
	@:optional
	var crosshair: Bool;
	@:optional
	var wielditem: Bool;
	@:optional
	var breathbar: Bool;
	@:optional
	var minimap: Bool;
	@:optional
	var minimap_radar: Bool;
	@:optional
	var basic_debug: Bool;
	@:optional
	var chat: Bool;
}
