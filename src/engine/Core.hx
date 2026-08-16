package src.engine;

import haxe.Constraints.Function;
import haxe.Rest;
import haxe.extern.EitherType;
import lua.Table;
import src.engine.compilercode.LuaArray;
import src.engine.definition.ItemDefinition;
import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.PointedThing;
import src.engine.definition.sound.SimpleSoundSpecTable.SimpleSoundSpec;
import src.engine.definition.sound.SoundParameterTable;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefEntity;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.metadata.NodeMetaRef;
import src.engine.metadata.StorageRef;
import src.engine.vector.Vec2;
import src.engine.vector.Vec3;
import src.game.entity.ItemEntity;

@:native("core")
extern class Core {
	// This may cause issues if you try to run functions.
	@:native("registered_items")
	static final registeredItems: Table<String, ItemDefinition>;

	@:native("registered_nodes")
	static final registeredNodes: Table<String, NodeDefinition>;

	static final settings: EngineSettings;

	static function log(level: LogLevel, text: String): Void;

	// This is the real function.
	@:noCompletion
	static function register_entity(name: String, prototype: Dynamic): Void;

	// @:native("register_node")
	// static function registerNode(name: String, def: Dynamic): Void;
	// @:native("register_craftitem")
	// static function registerCraftItem(name: String, def: Dynamic): Void;
	// @:native("register_tool")
	// static function registerTool(name: String, def: Dynamic): Void;
	// @:native("override_item")
	// static function overrideItem(name: String, redef: Dynamic, ?delFields: Dynamic): Void;
	//
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
	static function getObjectsInsideRadius(center: Vec3, radius: Float): LuaArray<ObjectRefBase>;

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
		toolCapabilities: Null<Dynamic>, dir: Vec3, damage: Int) -> Bool): Void;

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

	@:native("item_pickup")
	static function itemPickup(
		itemstack: ItemStack,
		picker: Null<ObjectRefBase>,
		pointedThing: PointedThing,
		timeFromLastPunch: Float): Null<ItemStack>;

	@:native("node_punch")
	static function nodePunch(pos: Vec3, node: NodeTable, puncher: Null<ObjectRefBase>, pointedThing: PointedThing): Void;

	@:native("node_dig")
	static function nodeDig(pos: Vec3, node: NodeTable, digger: Null<ObjectRefBase>): Bool;

	@:native("remove_node")
	static function removeNode(pos: Vec3): Void;

	@:native("get_node_timer")
	static function getNodeTimer(pos: Vec3): NodeTimerRef;

	@:native("get_meta")
	static function getMeta(pos: Vec3): NodeMetaRef;

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
	static function registerOnGeneratedMapgenThread(delegate: (voxelManip: VoxelManip, minPos: Vec3, maxPos: Vec3, blockSeed: Int) -> Void): Void;

	@:native("get_value_noise_map")
	static function getValueNoiseMap(noiseParams: NoiseParams, size: EitherType<Vec2, Vec3>): ValueNoiseMap;

	@:native("get_mapgen_setting")
	static function getMapgenSetting(name: String): String;

	@:native("generate_ores")
	static function generateOres(vm: VoxelManip, ?pos1: Vec3, ?pos2: Vec3): Void;

	@:native("generate_decorations")
	static function generateDecorations(vm: VoxelManip, ?pos1: Vec3, ?pos2: Vec3, ?useMapgenBiomes: Bool): Void;

	@:native("dir_to_yaw")
	static function dirToYaw(dir: Vec3): Float;

	@:native("yaw_to_dir")
	static function yawToDir(yaw: Float): Vec3;

	@:native("get_node")
	static function getNode(pos: Vec3): NodeTable;

	@:native("get_node_or_nil")
	static function getNodeOrNull(pos: Vec3): Null<NodeTable>;

	@:native("set_node")
	static function setNode(pos: Vec3, node: NodeTable): Void;

	@:native("dig_node")
	static function digNode(pos: Vec3, ?digger: ObjectRefBase): Bool;

	@:native("get_item_group")
	static function getItemGroup(name: String, group: String): Int;

	@:native("chat_send_all")
	static function chatSendAll(text: String): Void;

	@:native("chat_send_player")
	static function chatSendPlayer(name: String, text: String): Void;

	@:native("show_formspec")
	static function showFormspec(playername: String, formname: String, formspec: String): Void;

	@:native("get_worldpath")
	static function getWorldPath(): String;

	@:native("get_us_time")
	static function getUSTime(): Float;

	@:native("set_timeofday")
	static function setTimeOfDay(time: Float): Void;

	@:native("get_timeofday")
	static function getTimeOfDay(): Float;

	@:native("get_gametime")
	static function getGameTime(): Float;

	@:native("get_day_count")
	static function getDayCount(): Float;

	@:native("add_entity")
	static function addEntity(pos: Vec3, name: String, ?staticData: String): Null<ObjectRefEntity>;

	@:native("register_on_player_receive_fields")
	static function registerOnPlayerReceiveFields(func: (player: ObjectRefPlayer, formName: String, fields: Table<String, String>) -> Void): Void;

	// todo: type inventoryInfo
	@:native("register_on_player_inventory_action")
	static function registerOnPlayerInventoryAction(func: (player: Null<ObjectRefPlayer>, action: String, inventory: InvRef, inventoryInfo: InventoryActionInfo) -> Void): Void;

	@:native("sound_play")
	static function soundPlay(spec: SimpleSoundSpec, parameters: SoundParameterTable, ?ephemeral: Bool): Null<Int>;

	// ! Only overrideable functions below this.
	@:native("spawn_item")
	dynamic static function spawnItem(pos: Vec3, item: EitherType<String, ItemStack>): Null<ObjectRefEntity>;

	@:native("item_drop")
	dynamic static function itemDrop(
		itemstack: ItemStack,
		dropper: Null<ObjectRefBase>,
		pos: Vec3): ReturnItemStackObjectRef;

	// !
	// ! Custom stuff below this. ONLY USE VIRTUAL FUNCTIONS! (INLINE)
	// !
	public static inline function getMapSeedString(): String {
		return untyped __lua__('core.get_mapgen_setting("seed")');
	}

	public static inline function getObjectByGUID(guid: String): Null<ObjectRefEntity> {
		return untyped __lua__('core.objects_by_guid[{0}]', guid);
	}
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
	var pos: Null<Vec3>;
}

@:native("")
extern class Global {
	static function dump(a: Rest<Any>): String;
	static function dump2(a: Rest<Any>): String;
}

// ! Specialty functions. These change the way the game engine's base lua library functions.

@:final
@:noCompletion
abstract class ModifyInternalLibrary {
	static function deployModifications() {
		Core.spawnItem = (pos: Vec3, item: EitherType<String, ObjectRefEntity>) -> {
			// Take item in any format.
			var stack = ItemStack.create(item);
			var obj = Core.addEntity(pos, "__builtin:item");
			// Don't use obj if it couldn't be added to the map.
			if (obj != null) {
				(cast obj.getLuaEntity() : ItemEntity).setItem(stack.toString());
			}
			return obj;
		}
	}

	static function __init__() {
		deployModifications();
	}
}
