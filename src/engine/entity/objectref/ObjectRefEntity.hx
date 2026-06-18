package engine.entity.objectref;

import engine.vector.EngineVector3;

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

	@:native("set_yaw")
	public abstract function setYaw(yaw: Float): Void;

	@:native("get_yaw")
	public abstract function getYaw(): Float;

	@:native("set_texture_mod")
	public abstract function setTextureMod(mod: Dynamic): Void;

	@:native("get_texture_mod")
	public abstract function getTextureMod(): Dynamic;

	@:native("set_sprite")
	public abstract function setSprite(startFrame: Dynamic, numFrames: Int, frameLength: Float, selectXByCamera: Bool): Void;

	@:native("get_luaentity")
	public abstract function getLuaEntity(): LuaEntity;
}
