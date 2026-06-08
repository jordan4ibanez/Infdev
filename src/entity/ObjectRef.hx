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

	@:native("is_valid")
	public abstract function isValid(): Bool;

	@:native("get_pos")
	final public function getPos(): EngineVector3;

	final public function getPosFast(output: Vec3): Void {
		return untyped Vec3.fromEngineFast(__lua__("self.object:get_pos()"), output);
	}

	final public function setPos(pos: Vec3): Void {
		untyped __lua__("self.object:set_pos(pos)");
	}

	final public function addPos(posAddition: Vec3): Void {
		untyped __lua__("self.object:add_pos(pos)");
	}

	final public function getVelocity(): Vec3 {
		return untyped Vec3.fromEngine(__lua__("self.object:get_velocity()"));
	}

	final public function getVelocityFast(output: Vec3): Void {
		return untyped Vec3.fromEngineFast(__lua__("self.object:get_velocity()"), output);
	}

	final public function addVelocity(vel: Vec3): Void {
		untyped __lua__("self.object:add_velocity(vel)");
	}

	final public function moveTo(pos: Vec3, continuous: Bool = false): Void {
		untyped __lua__("self.object:move_to(pos, continuous)");
	}

	final public function punch(puncher: Null<ObjectRef>, time_from_last_punch: Null<Float>, tool_capabilities: Dynamic, dir: Null<Vec3>): Void {
		untyped __lua__("self.object:punch(puncher, time_from_last_punch, tool_capabilities, dir)");
	}

	final public function getGUID(): String {
		return untyped __lua__("self.object:get_guid()");
	};
}
