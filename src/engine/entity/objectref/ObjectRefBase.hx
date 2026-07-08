package src.engine.entity.objectref;

import src.engine.compilercode.LuaArray;
import src.engine.vector.EngineVector2;
import src.engine.vector.EngineVector3;

@:multiReturn
extern class GetAnimationReturn {
	@:native("frame_range")
	public var frameRange: EngineVector2;
	@:native("frame_speed")
	public var frameSpeed: Float;
	@:native("frame_blend")
	public var frameBlend: Float;
	@:native("frame_loop")
	public var frameLoop: Bool;
}

/**
 * A Luanti C++ engine ServerActiveObject reference.
 * This is the base form of it for when you do not know if it is an entity or a player.
 */
abstract class ObjectRefBase {
	private final function new() {}

	// ? Begin baked in engine entity features made nicer to use.
	//
	// Plain lua object reference methods:
	//
	//* begins: is_valid
	//* ends: get_guid

	@:native("is_valid")
	public abstract function isValid(): Bool;

	@:native("get_pos")
	public abstract function getPos(): EngineVector3;

	// final public function getPosFast(output: Vec3): Void {
	// 	return untyped Vec3.fromEngineFast(__lua__("self.object:get_pos()"), output);
	// }

	@:native("set_pos")
	public abstract function setPos(pos: EngineVector3): Void;

	@:native("add_pos")
	public abstract function addPos(posAddition: EngineVector3): Void;

	@:native("get_velocity")
	public abstract function getVelocity(): EngineVector3;

	// final public function getVelocityFast(output: Vec3): Void {
	// 	return untyped Vec3.fromEngineFast(__lua__("self.object:get_velocity()"), output);
	// }

	@:native("add_velocity")
	public abstract function addVelocity(vel: EngineVector3): Void;

	@:native("move_to")
	public abstract function moveTo(pos: EngineVector3, ?continuous: Bool): Void;

	@:native("punch")
	public abstract function punch(puncher: Null<ObjectRefBase>, time_from_last_punch: Null<Float>, tool_capabilities: Dynamic, dir: Null<EngineVector3>): Void;

	@:native("right_click")
	public abstract function rightClick(clicker: ObjectRefBase): Void;

	@:native("get_hp")
	public abstract function getHP(): Int;

	@:native("set_hp")
	public abstract function setHP(hp: Int, ?reason: Dynamic): Void;

	@:native("get_inventory")
	public abstract function getInventory(): Null<Dynamic>;

	@:native("get_wield_list")
	public abstract function getWieldList(): LuaArray<Dynamic>;

	@:native("get_wield_index")
	public abstract function getWieldIndex(): Int;

	@:native("get_wielded_item")
	public abstract function getWieldedItem(): Dynamic;

	@:native("set_wielded_item")
	public abstract function setWieldedItem(item: Dynamic, skipAnimation: Bool): Void;

	@:native("get_armor_groups")
	public abstract function getArmorGroups(): Dynamic;

	@:native("set_armor_groups")
	public abstract function setArmorGroups(groupTable: Dynamic): Void;

	// Old style 5.16 and below
	// @:native("set_animation")
	// public abstract function setAnimation(frameRange: EngineVector2, frameSpeed: Float, frameBlend: Float, frameLoop: Bool): Void;
	// @:native("get_animation")
	// public abstract function getAnimation(): GetAnimationReturn;
	// @:native("set_animation_frame_speed")
	// public abstract function setAnimationFrameSpeed(frameSpeed: Float): Void;

	@:native("set_attach")
	public abstract function setAttach(parent: ObjectRefBase, bone: String, position: EngineVector3, rotation: EngineVector3, forcedVisible: Bool): Void;

	@:native("get_attach")
	public abstract function getAttach(): Null<Dynamic>;

	@:native("get_children")
	public abstract function getChildren(): LuaArray<Dynamic>;

	@:native("set_detach")
	public abstract function setDetach(): Void;

	@:native("set_bone_override")
	public abstract function setBoneOverride(bone: String, overRide: Dynamic): Void;

	@:native("get_bone_override")
	public abstract function getBoneOverride(bone: String): Dynamic;

	@:native("get_bone_overrides")
	public abstract function getBoneOverrides(): LuaArray<Dynamic>;

	@:native("set_properties")
	public abstract function setProperties(propTable: ObjectProperties): Void;

	@:native("get_properties")
	public abstract function getProperties(): ObjectProperties;

	@:native("set_observers")
	public abstract function setObservers(observers: LuaArray<Dynamic>): Void;

	@:native("get_observers")
	public abstract function getObservers(): LuaArray<Dynamic>;

	@:native("get_effective_observers")
	public abstract function getEffectiveObservers(): LuaArray<Dynamic>;

	@:native("is_player")
	public abstract function isPlayer(): Bool;

	@:native("get_nametag_attributes")
	public abstract function getNametagAttributes(): Dynamic;

	@:native("set_nametag_attributes")
	public abstract function setNametagAttributes(attributes: Dynamic): Void;

	@:native("get_guid")
	public abstract function getGUID(): String;
}
