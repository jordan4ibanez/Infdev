package entity;

import lua.Lua;

@:autoBuild(luanti_types.EntityDuctTape.build())
@:build(luanti_types.EntityDuctTape.build())
class Entity {
	// This returns this.
	public function new() {}

	@:native("on_activate")
	public function onActivate(staticData: String, dtimeS: Float) {
		// trace(this.uuid);
		Lua.print("hello world! from Entity");
	}

	@:native("on_deactivate")
	public function onDeactivate(removal: Bool) {}

	@:native("on_step")
	public function onStep(delta: Float) {}

	final public function getGUID(): String {
		return untyped __lua__("self.object:get_guid()");
	};
}
