package entity.objectref;

import vector.EngineVector3;

/**
 * A Luanti C++ engine ServerActiveObject reference.
 * This is the form of it to cast into when you know it is an entity.
 */
abstract class ObjectRefEntity extends ObjectRefBase {
	@:native("remove")
	public abstract function remove(): Void;

	@:native("set_velocity")
	public abstract function setVelocity(vel: EngineVector3): Void;

	@:native("set_acceleration")
	public abstract function setAcceleration(acc: EngineVector3): Void;

	@:native("get_acceleration")
	public abstract function getAcceleration(): EngineVector3;

	@:native("set_rotation")
	public abstract function setRotation(rot: EngineVector3): Void;

	@:native("get_rotation")
	public abstract function getRotation(): EngineVector3;
	
}
