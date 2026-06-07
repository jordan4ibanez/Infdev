package entity;

import lua.Lua;

@:autoBuild(luanti_types.EntityDuctTape.build())
@:build(luanti_types.EntityDuctTape.build())
class Entity {
	public final object: Dynamic = null;

	// This returns this.
	public function new() {}

	// ? Here begins programmer facing overrideable methods.

	@:native("on_activate")
	public function onActivate(staticData: String, dtimeS: Float) {
		// trace(this.uuid);
		Lua.print("hello world! from Entity");
	}

	@:native("on_deactivate")
	public function onDeactivate(removal: Bool) {}

	// todo: fix this dynamic mess.

	@:native("on_step")
	public function onStep(delta: Float, moveResult: Dynamic) {}

	@:native("on_punch")
	public function onPunch(puncher: Dynamic, timeFromLastPunch: Float, toolCapabilities: Dynamic, dir: Dynamic, damager: Int) {}

	@:native("on_death")
	public function onDeath(?killer: Dynamic) {}

	@:native("on_rightclick")
	public function onRightClick(clicker: Dynamic) {}

	@:native("on_attach_child")
	public function onAttachChild(child: Dynamic) {}

	@:native("on_detach_child")
	public function onDetachChild(child: Dynamic) {}

	@:native("on_detach")
	public function onDetach(parent: Dynamic) {}

	@:native("get_staticdata")
	public function getStaticData(): String {
		return "";
	}

	final public function getGUID(): String {
		return untyped __lua__("self.object:get_guid()");
	};
}
