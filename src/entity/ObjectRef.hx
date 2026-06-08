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

	/**
	 * Returns whether the object is valid. 
	 * @return Bool If it's valid.
	 */
	final public function isValid(): Bool {
		return untyped __lua__("self.object:is_valid()");
	}

	/**
	 * Get this object's position. This will hammer the GC.
	 * @return Vec3 The object's position.
	 */
	final public function getPos(): Vec3 {
		return untyped Vec3.fromEngine(__lua__("self.object:get_pos()"));
	}

	/**
	 * Get this objects position and transfer it into a Vec3.
	 * @param output A Vec3 to store the position it's in.
	 */
	final public function getPosFast(output: Vec3): Void {
		return untyped Vec3.fromEngineFast(__lua__("self.object:get_pos()"), output);
	}

	/**
	 * Set this object's position.
	 * @param pos The new position.
	 */
	final public function setPos(pos: Vec3): Void {
		untyped __lua__("self.object:set_pos(pos)");
	}

	/**
	 * Changes position by adding to the current position.
	 * No-op if object is attached.
	 * @param posAddition The addition to the position.
	 */
	final public function addPos(posAddition: Vec3): Void {
		untyped __lua__("self.object:add_pos(pos)");
	}

	/**
	 * Get the object's velocity. This will hammer the GC.
	 * @return Vec3 The velocity.
	 */
	final public function getVelocity(): Vec3 {
		return untyped Vec3.fromEngine(__lua__("self.object:get_velocity()"));
	}

	final public function getGUID(): String {
		return untyped __lua__("self.object:get_guid()");
	};
}
