package entity;

import vector.Vec3;
import lua.Lua;

// ? This is the base blueprint of LuaEntity and Player.
abstract class ObjectRef {
	public final object: Dynamic = null;

	// This returns this.
	public function new() {}

	// ? Begin baked in engine entity features made nicer to use.
	//
	// Plain lua object reference methods:
	//
	//* begins: is_valid
	//* ends: get_guid

	final public function isValid(): Bool {
		return untyped __lua__("self.object:is_valid()");
	}

	final public function getPos(): Vec3 {
		return untyped Vec3.fromEngine(__lua__("self.object:get_pos()"));
	}

	final public function getGUID(): String {
		return untyped __lua__("self.object:get_guid()");
	};
}
