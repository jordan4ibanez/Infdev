package entity;

import vector.Vec3;
import lua.Lua;

// ? This is the C++ entity inside of a lua entity.
abstract class ObjectRef {
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

	/**
	 * Get the object's velocity and transfer it into a Vec3.
	 * @param output A Vec3 to store the velocity.
	 */
	final public function getVelocityFast(output: Vec3): Void {
		return untyped Vec3.fromEngineFast(__lua__("self.object:get_velocity()"), output);
	}

	/**
	 * Changes velocity by adding to the current velocity.
	 * @param vel The velocity to add.
	 */
	final public function addVelocity(vel: Vec3): Void {
		untyped __lua__("self.object:add_velocity(vel)");
	}

	/**
	 * Does an interpolated move for Lua entities for visually smooth transitions.
	 * @param pos Position to move to.
	 * @param continuous If continuous is true, the Lua entity will not be moved to the current position before starting the interpolated move.
	 */
	final public function moveTo(pos: Vec3, continuous: Bool = false): Void {
		untyped __lua__("self.object:move_to(pos, continuous)");
	}

	/**
	 * Punches the object, triggering all consequences a normal punch would have
	 * @param puncher another ObjectRef which punched the object (can be nil)
	 * @param time_from_last_punch Meant for disallowing spamming of clicks (can be nil)
	 * @param tool_capabilities capability table of used item
	 * @param dir direction vector. Points from the puncher to the punched (can be nil)
	 */
	final public function punch(puncher: Null<ObjectRef>, time_from_last_punch: Null<Float>, tool_capabilities: Dynamic, dir: Null<Vec3>): Void {
		untyped __lua__("self.object:punch(puncher, time_from_last_punch, tool_capabilities, dir)");
	}

	final public function getGUID(): String {
		return untyped __lua__("self.object:get_guid()");
	};
}
