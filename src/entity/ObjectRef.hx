package entity;

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

	final public function getGUID(): String {
		return untyped __lua__("self.object:get_guid()");
	};
}
