package src.engine.definition;

import lua.Table;
import src.engine.Core;
import src.engine.compilercode.LuaArray;
import src.engine.compilercode.LuaMap;
import src.engine.definition.MaxLevel.MAX_LEVEL;
import src.engine.definition.basic.ConnectSides;
import src.engine.definition.basic.DrawType;
import src.engine.definition.basic.LiquidType;
import src.engine.definition.basic.NodeDropTable;
import src.engine.definition.basic.ParamType1;
import src.engine.definition.basic.ParamType2;
import src.engine.definition.basic.TileDefinition;
import src.engine.definition.basic.WavingType;
import src.engine.definition.graphics.ColorSpec;
import src.engine.definition.graphics.NodeTextureAlpha;
import src.engine.definition.sound.NodeSoundTable;
import src.engine.entity.objectref.ObjectRefBase;
import src.engine.metadata.NodeMetaRef;
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
 */
@:luantiDefinitionRoot
class NodeDefinition extends ItemDefinition {
	@:native("groups")
	public var nodeGroups: LuaMap<NodeGroup, Int>;

	@:native("drawtype")
	var drawType: DrawType;

	@:native("visual_scale")
	var visualScale: Float;

	var tiles: LuaArray<TileDefinitionOrString>;

	@:native("overlay_tiles")
	var overlayTiles: LuaArray<TileDefinitionOrString>;

	@:native("special_tiles")
	var specialTiles: LuaArray<TileDefinitionOrString>;

	/**
	 * This one is for nodes.
	 */
	@:native("color")
	var nodeColor: ColorSpec;

	@:native("use_texture_alpha")
	var useTextureAlpha: NodeTextureAlpha;

	@:native("post_effect_color")
	var postEffectColor: ColorSpec;

	@:native("post_effect_color_shaded")
	var postEffectColorShaded: Bool;

	@:native("paramtype")
	var paramtype1: ParamType1;

	var paramtype2: ParamType2;

	@:native("wallmounted_rotate_vertical")
	var wallmountedRotateVertical: Bool;

	@:native("is_ground_content")
	var isGroundContent: Bool;

	@:native("sunlight_propagates")
	var sunlightPropagates: Bool;

	var walkable: Bool;

	var pointable: Bool;

	var diggable: Bool;

	var climbable: Bool;

	@:native("buildable_to")
	var buildableTo: Bool;

	var floodable: Bool;

	@:native("liquidtype")
	var liquidType: LiquidType;

	@:native("liquid_alternative_flowing")
	var liquidAlternativeFlowing: String;

	@:native("liquid_alternative_source")
	var liquidAlternativeSource: String;

	@:native("liquid_viscosity")
	var liquidViscosity: Int;

	@:native("liquid_renewable")
	var liquidRenewable: Bool;

	@:native("liquid_move_physics")
	var liquidMovePhysics: Bool;

	@:native("air_equivalent")
	var airEquivalent: Bool;

	var leveled: Int;

	@:native("leveled_max")
	var leveledMax: Int;

	@:native("liquid_range")
	var liquidRange: Int;

	var drowning: Int;

	@:native("damage_per_second")
	var damagePerSecond: Int;

	@:native("node_box")
	var nodeBox: NodeBox;

	@:native("connects_to")
	var connectsTo: LuaArray<String>;

	@:native("connect_sides")
	var connectSides: LuaArray<ConnectSides>;

	var mesh: String;

	@:native("selection_box")
	var selectionBox: NodeBox;

	@:native("collision_box")
	var collisionBox: NodeBox;

	@:native("legacy_facedir_simple")
	var legacyFacedirSimple: Bool;

	@:native("legacy_wallmounted")
	var legacyWallmounted: Bool;

	var waving: WavingType;

	/**
	 * This one is for nodes.
	 */
	@:native("sounds")
	var nodeSounds: NodeSoundTable;

	var drop: NodeDropTableOrString;

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
	public function onReceiveFields(pos: Vec3, formName: String, fields: Table<Dynamic, Dynamic>, sender: Null<ObjectRefBase>): Void {
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

	public function new() {
		super();
	}

	@:native("mod_origin")
	public final modOrigin: String = "engineUse";
}
