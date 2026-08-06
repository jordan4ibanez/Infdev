package src.engine.definition;

import lua.Table;
import src.engine.Core;
import src.engine.compilercode.LuaArray;
import src.engine.compilercode.LuaMap;
import src.engine.definition.basic.ConnectSides;
import src.engine.definition.basic.DrawType;
import src.engine.definition.basic.LiquidType;
import src.engine.definition.basic.MaxLevel.MAX_LEVEL;
import src.engine.definition.basic.NodeBox;
import src.engine.definition.basic.NodeDropTable;
import src.engine.definition.basic.ParamType1;
import src.engine.definition.basic.ParamType2;
import src.engine.definition.basic.PointedThing;
import src.engine.definition.basic.TileDefinition;
import src.engine.definition.basic.WavingType;
import src.engine.definition.graphics.ColorSpec;
import src.engine.definition.graphics.NodeTextureAlpha;
import src.engine.definition.sound.NodeSoundTable;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.metadata.NodeMetaRef;
import src.engine.vector.Vec3;
import src.game.groups.NodeGroup;

inline final MAX_NODE_LEVEL = MAX_LEVEL;

/**
 * When you extend this class, you get a specialty class which is extremely interesting.
 * 
 * The extended class is wrapped in a static class.
 * 
 * Defined vars are all copied to the static class. (They are virtual final)
 * 
 * Defined methods are copied to the static class and wrapped in static methods.
 * 
 * ! Warning: Do not call an override API method unless you define it. It doesn't exist.
 * 
 * Feel free to edit your custom vars during runtime.
 * 
 * Never call another override function unless 
 * 
 * Also another note: This one is for nodes. 
 * Use the ItemDefinition class for items.
 * Use the ToolDefinition class for tools.
 * Use the OreDefinition class for ores.
 */
@:luantiDefinitionRoot
class NodeDefinition extends ItemDefinition {
	@:native("groups")
	public var nodeGroups: LuaMap<NodeGroup, Int>;

	@:native("drawtype")
	public var drawType: DrawType;

	@:native("visual_scale")
	public var visualScale: Float;

	public var tiles: LuaArray<TileDefinitionOrString>;

	@:native("overlay_tiles")
	public var overlayTiles: LuaArray<TileDefinitionOrString>;

	@:native("special_tiles")
	public var specialTiles: LuaArray<TileDefinitionOrString>;

	/**
	 * This one is for nodes.
	 */
	@:native("color")
	public var nodeColor: ColorSpec;

	@:native("use_texture_alpha")
	public var useTextureAlpha: NodeTextureAlpha;

	@:native("post_effect_color")
	public var postEffectColor: ColorSpec;

	@:native("post_effect_color_shaded")
	public var postEffectColorShaded: Bool;

	@:native("paramtype")
	public var paramtype1: ParamType1;

	public var paramtype2: ParamType2;

	@:native("wallmounted_rotate_vertical")
	public var wallmountedRotateVertical: Bool;

	@:native("is_ground_content")
	public var isGroundContent: Bool;

	@:native("sunlight_propagates")
	public var sunlightPropagates: Bool;

	public var walkable: Bool;

	public var pointable: Bool;

	public var diggable: Bool;

	public var climbable: Bool;

	@:native("buildable_to")
	public var buildableTo: Bool;

	public var floodable: Bool;

	@:native("liquidtype")
	public var liquidType: LiquidType;

	@:native("liquid_alternative_flowing")
	public var liquidAlternativeFlowing: String;

	@:native("liquid_alternative_source")
	public var liquidAlternativeSource: String;

	@:native("liquid_viscosity")
	public var liquidViscosity: Int;

	@:native("liquid_renewable")
	public var liquidRenewable: Bool;

	@:native("liquid_move_physics")
	public var liquidMovePhysics: Bool;

	@:native("air_equivalent")
	public var airEquivalent: Bool;

	public var leveled: Int;

	@:native("leveled_max")
	public var leveledMax: Int;

	@:native("liquid_range")
	public var liquidRange: Int;

	public var drowning: Int;

	@:native("damage_per_second")
	public var damagePerSecond: Int;

	@:native("node_box")
	public var nodeBox: NodeBox;

	@:native("connects_to")
	public var connectsTo: LuaArray<String>;

	@:native("connect_sides")
	public var connectSides: LuaArray<ConnectSides>;

	public var mesh: String;

	@:native("selection_box")
	public var selectionBox: NodeBox;

	@:native("collision_box")
	public var collisionBox: NodeBox;

	@:native("legacy_facedir_simple")
	public var legacyFacedirSimple: Bool;

	@:native("legacy_wallmounted")
	public var legacyWallmounted: Bool;

	public var waving: WavingType;

	/**
	 * This one is for nodes.
	 */
	@:native("sounds")
	public var nodeSounds: NodeSoundTable;

	public var drop: NodeDropTableOrString;

	public function onConstruct(pos: Vec3): Void {
		// nil
	}

	public function onDestruct(pos: Vec3): Void {
		// nil
	}

	public function afterDestruct(pos: Vec3, oldNode: NodeTable) {
		// nil
	}

	public function onFlood(pos: Vec3, oldNode: NodeTable, newNode: NodeTable): Bool {
		// nil
		return false;
	}

	public function preserveMetadata(pos: Vec3, oldNode: NodeTable, oldMeta: NodeMetaRef, drops: Table<Int, ItemStack>): Void {
		// nil
	}

	public function afterPlaceNode(pos: Vec3, placer: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: PointedThing): Bool {
		// nil
		return false;
	}

	public function afterDigNode(pos: Vec3, oldNode: NodeTable, oldMetaData: NodeMetaRef, digger: Null<ObjectRefBase>): Void {
		// nil
	}

	public function canDig(pos: Vec3, player: Null<ObjectRefBase>): Bool {
		// nil
		return true;
	}

	public function onPunch(pos: Vec3, node: NodeTable, puncher: Null<ObjectRefBase>, pointedThing: PointedThing): Void {
		// core.node_punch
		Core.nodePunch(pos, node, puncher, pointedThing);
	}

	public function onRightClick(pos: Vec3, node: NodeTable, clicker: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: Null<PointedThing>): ItemStack {
		// nil
		return itemStack;
	}

	public function onDig(pos: Vec3, node: NodeTable, digger: Null<ObjectRefBase>): Bool {
		// core.node_dig;
		return Core.nodeDig(pos, node, digger);
	}

	public function onTimer(pos: Vec3, elapsed: Float, node: NodeTable, timeout: Float): Bool {
		// nil
		return false;
	}

	// ? note: this one is OK to use Dynamic!
	public function onReceiveFields(pos: Vec3, doNotUse: String, fields: Table<String, String>, sender: Null<ObjectRefBase>): Void {
		// nil
	}

	public function allowMetadataInventoryMove(pos: Vec3, fromList: String, fromIndex: Int, toList: String, toIndex: Int, count: Int, player: Null<ObjectRefBase>): Int {
		// literally does not say so nil
		return count;
	}

	public function allowMetadataInventoryPut(pos: Vec3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Int {
		// literally does not say so nil
		return -1;
	}

	public function allowMetadataInventoryTake(pos: Vec3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Int {
		// literally does not say so nil
		return -1;
	}

	public function onMetadataInventoryMove(pos: Vec3, fromList: String, fromIndex: Int, toList: String, toIndex: Int, count: Int,
		player: Null<ObjectRefBase>): Void {
		// nil
	}

	public function onMetadataInventoryPut(pos: Vec3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Void {
		// nil
	}

	public function onMetadataInventoryTake(pos: Vec3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Void {
		// nil
	}

	public function onBlast(pos: Vec3, intensity: Float): Void {
		// nil
	}

	final DEBUG_TERRAIN_MODE = false;

	public function new() {
		super();

		// Allows players to feel the tickrate of the server.
		// todo: But, there's no placement audio. Soooo, that's gotta be implemented separately.
		// this.nodePlacementPrediction = "";

		if (DEBUG_TERRAIN_MODE) {
			this.lightSource = 14;
		}
	}

	@:native("mod_origin")
	public final modOrigin: String = "engineUse";

	// ! Only custom stuff below this line.
	//
	//
	// This is a horrendous hackjob and it's awesome.
	var doClick = true;

	inline function reClick(player: ObjectRefPlayer, pointedThing: PointedThing) {
		doClick = !doClick;

		if (doClick) {
			Core.itemPlace(ItemStack.create(""), player, pointedThing);
		}
	}

	/**
	 * This allows a button or hitting enter in a field to exhibit the same behavior.
	 * @param fields 
	 * @param buttonName 
	 * @param elementName 
	 * @return Bool
	 */
	inline function fieldsButtonEnterCheck(fields: Table<String, String>, buttonName: String, targetField: String): Bool {
		if (fields.key_enter_field == targetField || fields[cast buttonName] != null) {
			return true;
		}
		return false;
	}
}
