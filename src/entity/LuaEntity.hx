package entity;

import entity.objectref.ObjectRefBase;

@:autoBuild(luantitypes.EntityDuctTape.build())
@:build(luantitypes.EntityDuctTape.build())
abstract class LuaEntity {
	final object: ObjectRefBase = null;

	// ? Here begins programmer facing overrideable methods.

	@:native("on_activate")
	public function onActivate(staticData: String, dtimeS: Float) {
		// trace(this.uuid);
		// Lua.print("hello world! from ObjectRef");
	}

	@:native("on_deactivate")
	public function onDeactivate(removal: Bool) {}

	// todo: fix this dynamic mess.
	// todo: fix return types.

	@:native("on_step")
	public function onStep(delta: Float, moveResult: Dynamic) {}

	@:native("on_punch")
	public function onPunch(puncher: Null<ObjectRefBase>, timeFromLastPunch: Float, toolCapabilities: Dynamic, dir: Dynamic, damager: Int) {}

	@:native("on_death")
	public function onDeath(killer: Null<ObjectRefBase>) {}

	@:native("on_rightclick")
	public function onRightClick(clicker: ObjectRefBase) {}

	@:native("on_attach_child")
	public function onAttachChild(child: ObjectRefBase) {}

	@:native("on_detach_child")
	public function onDetachChild(child: ObjectRefBase) {}

	@:native("on_detach")
	public function onDetach(parent: ObjectRefBase) {}

	@:native("get_staticdata")
	public function getStaticData(): String {
		return "";
	}

	// ? Begin baked in engine entity features made nicer to use.
	// ! If anything past this point isn't final, there's an issue.
	//
	// LuaEntity methods:
	//
	//* begins: remove
	//* ends: get_entity_name (which is deprecated, this thing should use a .name field)
}
