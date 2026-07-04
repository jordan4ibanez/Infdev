package src.engine.entity.objectref;

import lua.Table;
import src.engine.entity.definition.PhysicsOverride;
import src.engine.entity.helpers.PlayerHandling;
import src.engine.metadata.PlayerMetaRef;
import src.engine.vector.EngineVector2;
import src.engine.vector.EngineVector3;
import src.game.entity.Player;

@:multiReturn
class FOVReturnValue {
	public var fov: Float;
	public var isMultiplier: Bool;
	public var transitionTime: Float;
}

/**
 * A Luanti C++ engine ServerActiveObject reference.
 * This is the form of it to cast into when you know it is a player.
 */
abstract class ObjectRefPlayer extends ObjectRefBase {
	@:native("get_player_name")
	public abstract function getPlayerName(): String;

	@:native("get_look_dir")
	public abstract function getLookDir(): EngineVector3;

	@:native("get_look_vertical")
	public abstract function getLookVertical(): Float;

	@:native("get_look_horizontal")
	public abstract function getLookHorizontal(): Float;

	@:native("set_look_vertical")
	public abstract function setLookVertical(radians: Float): Void;

	@:native("set_look_horizontal")
	public abstract function setLookHorizontal(radians: Float): Void;

	@:native("get_breath")
	public abstract function getBreath(): Int;

	@:native("set_breath")
	public abstract function setBreath(value: Int): Void;

	@:native("set_fov")
	public abstract function setFOV(fov: Float, isMultiplier: Bool, ?transitionTime: Float): Void;

	@:native("get_fov")
	public abstract function getFOV(): FOVReturnValue;

	@:native("get_meta")
	public abstract function getMeta(): PlayerMetaRef;

	@:native("set_inventory_formspec")
	public abstract function setInventoryFormspec(formspec: String): Void;

	@:native("get_inventory_formspec")
	public abstract function getInventoryFormspec(): String;

	@:native("set_formspec_prepend")
	public abstract function setFormspecPrepend(formspec: String): Void;

	@:native("get_formspec_prepend")
	public abstract function getFormspecPrepend(): String;

	@:native("get_player_control")
	public abstract function getPlayerControl(): Dynamic;

	@:native("get_player_control_bits")
	public abstract function getPlayerControlBits(): Int;

	@:native("set_physics_override")
	public abstract function setPhysicsOverride(overrideTable: PhysicsOverride): Void;

	@:native("get_physics_override")
	public abstract function getPhysicsOverride(): PhysicsOverride;

	// todo: hud things

	@:native("hud_add")
	public abstract function hudAdd(hudDef: Dynamic): Int;

	@:native("hud_remove")
	public abstract function hudRemove(id: Int): Void;

	@:native("hud_change")
	public abstract function hudChange(id: Int, stat: String, value: Dynamic): Void;

	@:native("hud_get")
	public abstract function hudGet(): Dynamic;

	@:native("hud_get_all")
	public abstract function hudGetAll(): Table<Int, Dynamic>;

	@:native("hud_set_flags")
	public abstract function hudSetFlags(flags: Dynamic): Void;

	@:native("hud_get_flags")
	public abstract function hudGetFlags(): Dynamic;

	@:native("hud_set_hotbar_itemcount")
	public abstract function hudSetHotbarItemcount(count: Int): Void;

	@:native("hud_get_hotbar_itemcount")
	public abstract function hudGetHotbarItemcount(): Int;

	@:native("hud_set_hotbar_image")
	public abstract function hudSetHotbarImage(textureName: String): Void;

	@:native("hud_get_hotbar_image")
	public abstract function hudGetHotbarImage(): String;

	@:native("hud_set_hotbar_selected_image")
	public abstract function hudSetHotbarSelectedImage(texturename: String): Void;

	@:native("hud_get_hotbar_selected_image")
	public abstract function hudGetHotbarSelectedImage(): String;

	// todo: minimap modes

	@:native("set_minimap_modes")
	public abstract function setMinimapModes(modeTable: Dynamic, selectedMode: Int): Void;

	// todo: sky things and sun, moon, stars, clouds

	@:native("set_sky")
	public abstract function setSky(skyParameters: Dynamic): Void;

	@:native("get_sky")
	public abstract function getSky(asTable: Bool = true): Dynamic;

	@:native("set_sun")
	public abstract function setSun(sunParameters: Dynamic): Void;

	@:native("get_sun")
	public abstract function getSun(): Dynamic;

	@:native("set_moon")
	public abstract function setMoon(moonParameters: Dynamic): Void;

	@:native("get_moon")
	public abstract function getMoon(): Dynamic;

	@:native("set_stars")
	public abstract function setStars(starParameters: Dynamic): Void;

	@:native("get_stars")
	public abstract function getStars(): Dynamic;

	@:native("set_clouds")
	public abstract function setClouds(cloudParameters: Dynamic): Void;

	@:native("get_clouds")
	public abstract function getClouds(): Dynamic;

	@:native("override_day_night_ratio")
	public abstract function overrideDayNightRatio(?ratio: Float): Void;

	@:native("get_day_night_ratio")
	public abstract function getDayNightRatio(): Null<Float>;

	@:native("set_local_animation")
	public abstract function setLocalAnimation(idle: EngineVector2, walk: EngineVector2, dig: EngineVector2, walkWhileDig: EngineVector2, frameSpeed: Float): Void;

	// todo: lua multi return

	@:native("get_local_animation")
	public abstract function getLocalAnimation(): Dynamic;

	@:native("set_eye_offset")
	public abstract function setEyeOffset(firstPerson: EngineVector3, thirdPersonBack: EngineVector3, thirdPersonFront: EngineVector3): Void;

	// todo: lua multi return

	@:native("get_eye_offset")
	public abstract function getEyeOffset(): Dynamic;

	// todo: camera things

	@:native("set_camera")
	public abstract function setCamera(?params: Dynamic): Void;

	@:native("get_camera")
	public abstract function getCamera(): Dynamic;

	@:native("send_mapblock")
	public abstract function sendMapblock(blockPos: EngineVector3): Bool;

	// todo: lighting thing

	@:native("set_lighting")
	public abstract function setLighting(lightDef: Dynamic): Void;

	@:native("get_lighting")
	public abstract function getLighting(): Dynamic;

	@:native("respawn")
	public abstract function respawn(): Void;

	// todo: flags

	@:native("get_flags")
	public abstract function getFlags(): Dynamic;

	@:native("set_flags")
	public abstract function setFlags(flags: Dynamic): Void;

	public inline function getLuaEntity(): Player {
		return PlayerHandling.getGlobalLuaEntity(this.getPlayerName());
	}
}
