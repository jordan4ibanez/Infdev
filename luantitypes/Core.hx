package luantitypes;

import engine.NodeTimerRef;
import engine.entity.objectref.ObjectRefEntity;
import engine.definition.PointedThing;
import engine.ItemStack;
import haxe.Constraints.Function;
import engine.entity.objectref.ObjectRefPlayer;
import engine.entity.objectref.ObjectRefBase;
import engine.vector.EngineVector3;
import engine.entity.LuaEntity;
import haxe.Rest;
import Reflect;
import engine.metadata.StorageRef;
// These are public imports. :)
import engine.LogLevel;

@:native("core")
extern class Core {
	static function log(level: LogLevel, text: String): Void;

	// This is the real function.
	public static extern function register_entity(name: String, prototype: Dynamic): Void;

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

	// todo: node thing
	@:native("node_punch")
	static function nodePunch(pos: EngineVector3, node: Dynamic, puncher: Null<ObjectRefBase>, pointedThing: PointedThing): Void;

	// todo: node thing
	@:native("node_dig")
	static function nodeDig(pos: EngineVector3, node: Dynamic, digger: Null<ObjectRefBase>): Bool;

	@:native("remove_node")
	static function removeNode(pos: EngineVector3): Void;

	@:native("get_node_timer")
	static function getNodeTimer(pos: EngineVector3): NodeTimerRef;
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
