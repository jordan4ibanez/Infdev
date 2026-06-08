package entity;

import vector.LuantiVector3;
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
	public abstract function getPos(): LuantiVector3;

	// final public function getPosFast(output: Vec3): Void {
	// 	return untyped Vec3.fromEngineFast(__lua__("self.object:get_pos()"), output);
	// }

	@:native("set_pos")
	public abstract function setPos(pos: LuantiVector3): Void;

	@:native("add_pos")
	public abstract function addPos(posAddition: LuantiVector3): Void;

	@:native("get_velocity")
	public abstract function getVelocity(): LuantiVector3;

	// final public function getVelocityFast(output: Vec3): Void {
	// 	return untyped Vec3.fromEngineFast(__lua__("self.object:get_velocity()"), output);
	// }

	@:native("add_velocity")
	public abstract function addVelocity(vel: LuantiVector3): Void;

	@:native("move_to")
	public abstract function moveTo(pos: LuantiVector3, ?continuous: Bool): Void;

	@:native("punch")
	public abstract function punch(puncher: Null<ObjectRef>, time_from_last_punch: Null<Float>, tool_capabilities: Dynamic, dir: Null<LuantiVector3>): Void;

	@:native("get_guid")
	public abstract function getGUID(): String;
}
