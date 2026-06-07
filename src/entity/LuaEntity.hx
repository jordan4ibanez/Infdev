package entity;

@:autoBuild(luanti_types.EntityDuctTape.build())
@:build(luanti_types.EntityDuctTape.build())
class LuaEntity extends ObjectRef {
	// ? Here begins programmer facing overrideable methods.
	@:native("on_activate")
	public function onActivate(staticData: String, dtimeS: Float) {
		// trace(this.uuid);
		// Lua.print("hello world! from ObjectRef");
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
}
