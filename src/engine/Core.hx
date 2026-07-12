package src.engine;

import Reflect;
import haxe.Constraints.Function;
import haxe.Rest;
import src.engine.compilercode.LuaArray;
import src.engine.definition.PointedThing;
import src.engine.entity.LuaEntity;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.metadata.NodeMetaRef;
import src.engine.metadata.StorageRef;
import src.engine.vector.EngineVector2;

@:native("core")
extern class Core {
	static function log(level: LogLevel, text: String): Void;

	// This is the real function.
	public static function register_entity(name: String, prototype: Dynamic): Void;

	// This is the hijacked function.
	static public inline function registerEntity(name: String, clazz: Class<LuaEntity>): Void {
		var rawLuantiPrototype: Dynamic = {}
		// ? Works from the current class backwards until reached root (Entity).
		var currentClass: Class<Dynamic> = clazz;
		while (currentClass != null) {
			// trace("in class: " + Type.getClassName(currentClass));
			// Class components.
			var prototype = Reflect.field(currentClass, "prototype");
			for (method in Reflect.fields(prototype)) {
				untyped {
					if (rawLuantiPrototype[method] != null) {
						// trace("skipping method " + method + " already has it from child class");
						continue;
					}
					rawLuantiPrototype[method] = Reflect.getProperty(prototype, method);
				}
				// trace(method);
			}
			// Move up the inheritance tree.
			currentClass = Type.getSuperClass(currentClass);
		}
		Core.register_entity(name, rawLuantiPrototype);
	}

	@:native("register_node")
	static function registerNode(name: String, def: Dynamic): Void;

	@:native("register_craftitem")
	static function registerCraftItem(name: String, def: Dynamic): Void;

	@:native("register_tool")
	static function registerTool(name: String, def: Dynamic): Void;

	@:native("override_item")
	static function overrideItem(name: String, redef: Dynamic, ?delFields: Dynamic): Void;

	// fixme: this is incorrect.
	@:native("request_shutdown")
	static function requestShutdown(?message: String, ?reconnect: Bool, ?delay: Float): Void;

	/**
	 * DEFINE THIS IN PLAYER CLASS DON'T USE THIS.
	 */
	@:native("register_on_prejoinplayer")
	static function registerOnPreJoinPlayer(delegate: (name: String, ip: String) -> Void): Null<String>;

	/**
	 * DEFINE THIS IN PLAYER CLASS DON'T USE THIS.
	 */
	@:native("register_on_joinplayer")
	static function registerOnJoinPlayer(delegate: (player: ObjectRefPlayer, lastLogin: Null<Float>) -> Void): Void;

	/**
	 * DEFINE THIS IN PLAYER CLASS DON'T USE THIS.
	 */
	@:native("register_on_leaveplayer")
	static function registerOnLeavePlayer(delegate: (player: ObjectRefPlayer, timedOut: Bool) -> Void): Void;

	@:native("get_objects_inside_radius")
	static function getObjectsInsideRadius(center: EngineVector3, radius: Float): LuaArray<ObjectRefBase>;

	@:native("register_on_shutdown")
	static function registerOnShutDown(delegate: () -> Void): Void;

	@:native("register_globalstep")
	static function registerGlobalStep(delegate: (delta: Float) -> Void): Void;

	@:native("get_connected_players")
	static function getConnectedPlayers(): LuaArray<ObjectRefPlayer>;

	@:native("get_player_by_name")
	static function getPlayerByName(name: String): Null<ObjectRefPlayer>;

	@:native("register_on_newplayer")
	static function registerOnNewPlayer(delegate: (player: ObjectRefPlayer) -> Void): Void;

	@:native("register_on_punchplayer")
	static function registerOnPunchPlayer(delegate: (player: ObjectRefPlayer, hitter: Null<ObjectRefBase>, timeFromLastPunch: Null<Float>,
		toolCapabilities: Null<Dynamic>, dir: EngineVector3, damage: Int) -> Bool): Void;

	@:native("register_on_rightclickplayer")
	static function registerOnRightClickPlayer(delegate: (player: ObjectRefPlayer, clicker: Null<ObjectRefBase>) -> Void): Void;

	@:native("register_on_player_hpchange")
	static function registeronPlayerHPChange(delegate: (player: ObjectRefPlayer, hpChange: Int, reason: Dynamic) -> Int, modifier: Bool): Void;

	@:native("register_on_dieplayer")
	static function registerOnDiePlayer(delegate: (player: ObjectRefPlayer, reason: Dynamic) -> Void): Void;

	@:native("register_on_respawnplayer")
	static function registerOnRespawnPlayer(delegate: (player: ObjectRefPlayer) -> Bool): Void;

	@:native("after")
	static function after(time: Float, func: Function, anything: Rest<Dynamic>): Void;

	@:native("get_mod_storage")
	static function getModStorage(): StorageRef;

	@:native("serialize")
	static function serialize(data: Dynamic): String;

	@:native("deserialize")
	static function deserialize(str: String, ?safe: Bool): Dynamic;

	@:native("item_place")
	static function itemPlace(
		itemstack: ItemStack,
		placer: Null<ObjectRefBase>,
		pointedThing: PointedThing,
		?param2: Int): ReturnItemStackPosition;

	@:native("item_place_node")
	static function itemPlaceNode(
		itemstack: ItemStack,
		placer: Null<ObjectRefBase>,
		pointedThing: PointedThing,
		?param2: Int,
		?preventAfterPlace: Bool): ReturnItemStackPosition;

	@:native("item_secondary_use")
	static function itemSecondaryUse(itemstack: ItemStack, user: Null<ObjectRefBase>): Null<ItemStack>;

	@:native("item_drop")
	static function itemDrop(
		itemstack: ItemStack,
		dropper: Null<ObjectRefBase>,
		pos: EngineVector3): ReturnItemStackObjectRef;

	@:native("item_pickup")
	static function itemPickup(
		itemstack: ItemStack,
		picker: Null<ObjectRefBase>,
		pointedThing: PointedThing,
		timeFromLastPunch: Float): Null<ItemStack>;

	@:native("node_punch")
	static function nodePunch(pos: EngineVector3, node: NodeTable, puncher: Null<ObjectRefBase>, pointedThing: PointedThing): Void;

	@:native("node_dig")
	static function nodeDig(pos: EngineVector3, node: NodeTable, digger: Null<ObjectRefBase>): Bool;

	@:native("remove_node")
	static function removeNode(pos: EngineVector3): Void;

	@:native("get_node_timer")
	static function getNodeTimer(pos: EngineVector3): NodeTimerRef;

	@:native("get_meta")
	static function getMeta(pos: EngineVector3): NodeMetaRef;

	@:native("register_mapgen_script")
	static function registerMapgenScript(path: String): Void;

	@:native("get_current_modname")
	static function getCurrentModName(): String;

	@:native("get_modpath")
	static function getModPath(modName: String): Null<String>;

	@:native("get_modnames")
	static function getModNames(loadOrder: Bool): LuaArray<String>;

	@:native("register_alias")
	static function registerAlias(aliasName: String, thingToAlias: String): Void;

	@:native("set_mapgen_setting")
	static function setMapgenSetting(name: String, value: Dynamic, ?overrideMeta: Bool): Void;

	@:native("get_mapgen_chunksize")
	static function getMapgenChunkSize(): Int;

	@:native("get_content_id")
	static function getContentID(name: String): Int;

	// There are 2 register_on_generated.
	// Only generate the one for the terrain generator.
	// This is quite confusing for new users.
	// They at least need to be given separate names in the api.
	// They have 2 different argument lists and contexts.
	@:native("register_on_generated")
	static function registerOnGeneratedMapgenThread(delegate: (voxelManip: VoxelManip, minPos: EngineVector3, maxPos: EngineVector3, blockSeed: Int) -> Void): Void;

	@:native("get_value_noise_map")
	static function getValueNoiseMap(noiseParams: NoiseParams, size: EngineVector2): ValueNoiseMap;

	@:native("get_mapgen_setting")
	static function getMapgenSetting(name: String): String;

	@:native("generate_ores")
	static function generateOres(vm: VoxelManip, ?pos1: EngineVector3, ?pos2: EngineVector3): Void;

	@:native("generate_decorations")
	static function generateDecorations(vm: VoxelManip, ?pos1: EngineVector3, ?pos2: EngineVector3, ?useMapgenBiomes: Bool): Void;

	@:native("dir_to_yaw")
	static function dirToYaw(dir: EngineVector3): Float;

	@:native("yaw_to_dir")
	static function yawToDir(yaw: Float): EngineVector3;
}

@:noCompletion
@:multiReturn
extern class ReturnItemStackObjectRef {
	var itemstack: ItemStack;
	var objectRef: Null<ObjectRefEntity>;
}

@:noCompletion
@:multiReturn
extern class ReturnItemStackPosition {
	var itemstack: ItemStack;
	var pos: Null<EngineVector3>;
}

@:native("")
extern class Global {
	static function dump(a: Rest<Any>): String;
	static function dump2(a: Rest<Any>): String;
}
