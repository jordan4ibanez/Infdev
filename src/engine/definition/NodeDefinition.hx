package engine.definition;

import luantitypes.LuaArray;
import engine.metadata.NodeMetaRef;
import lua.Table;
import engine.definition.basic.ConnectSides;
import engine.definition.basic.NodeDropTable;
import engine.definition.sound.NodeSoundTable;
import engine.definition.basic.ParamType2;
import engine.definition.basic.ParamType1;
import engine.definition.graphics.NodeTextureAlpha;
import engine.definition.basic.TileDefinition;
import engine.definition.graphics.ColorSpec;
import engine.definition.basic.DrawType;
import engine.definition.basic.WavingType;
import engine.definition.basic.LiquidType;
import luantitypes.Core;
import engine.entity.objectref.ObjectRefBase;
import engine.vector.EngineVector3;
import engine.definition.graphics.TileAnimationDefinition;
import haxe.extern.EitherType;
import engine.definition.graphics.ItemImageDefinition;

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
	@:native("drawtype")
	var drawType: DrawType;

	@:native("visual_scale")
	var visualScale: Float;

	var tiles: LuaArray<TileDefinition>;

	@:native("overlay_tiles")
	var overlayTiles: LuaArray<TileDefinition>;

	@:native("special_tiles")
	var specialTiles: LuaArray<TileDefinition>;

	/**
	 * This one is for nodes.
	 */
	@:native("color")
	var nodeColor: ColorSpec;

	@:native("use_texture_alpha")
	var useTextureAlpha: NodeTextureAlpha;

	@:native("post_effect_color")
	var postEffectColor: String;

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

	var drop: NodeDropTable;

	public function onConstruct(pos: EngineVector3): Void {
		// nil
	}

	public function onDestruct(pos: EngineVector3): Void {
		// nil
	}

	public function afterDestruct(pos: EngineVector3, oldNode: NodeTable) {
		// nil
	}

	public function onFlood(pos: EngineVector3, oldNode: NodeTable, newNode: NodeTable): Bool {
		// nil
		return false;
	}

	public function preserveMetadata(pos: EngineVector3, oldNode: NodeTable, oldMeta: NodeMetaRef, drops: Table<Int, ItemStack>): Void {
		// nil
	}

	public function afterPlaceNode(pos: EngineVector3, placer: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: PointedThing): Bool {
		// nil
		return false;
	}

	public function afterDigNode(pos: EngineVector3, oldNode: NodeTable, oldMetaData: NodeMetaRef, digger: Null<ObjectRefBase>): Void {
		// nil
	}

	public function canDig(pos: EngineVector3, player: Null<ObjectRefBase>): Bool {
		// nil
		return true;
	}

	public function onPunch(pos: EngineVector3, node: NodeTable, puncher: Null<ObjectRefBase>, pointedThing: PointedThing): Void {
		// core.node_punch
		Core.nodePunch(pos, node, puncher, pointedThing);
	}

	public function onRightClick(pos: EngineVector3, node: NodeTable, clicker: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: Null<PointedThing>): ItemStack {
		// nil
		return itemStack;
	}

	public function onDig(pos: EngineVector3, node: NodeTable, digger: Null<ObjectRefBase>): Bool {
		// core.node_dig;
		return Core.nodeDig(pos, node, digger);
	}

	public function onTimer(pos: EngineVector3, elapsed: Float, node: NodeTable, timeout: Float): Bool {
		// nil
		return false;
	}

	// ? note: this one is OK to use Dynamic!
	public function onReceiveFields(pos: EngineVector3, formName: String, fields: Table<Dynamic, Dynamic>, sender: Null<ObjectRefBase>): Void {
		// nil
	}

	public function allowMetadataInventoryMove(pos: EngineVector3, fromList: String, fromIndex: Int, toList: String, toIndex: Int, count: Int, player: Null<ObjectRefBase>): Int {
		// literally does not say so nil
		return count;
	}

	public function allowMetadataInventoryPut(pos: EngineVector3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Int {
		// literally does not say so nil
		return -1;
	}

	public function allowMetadataInventoryTake(pos: EngineVector3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Int {
		// literally does not say so nil
		return -1;
	}

	public function onMetadataInventoryMove(pos: EngineVector3, fromList: String, fromIndex: Int, toList: String, toIndex: Int, count: Int,
		player: Null<ObjectRefBase>): Void {
		// nil
	}

	public function onMetadataInventoryPut(pos: EngineVector3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Void {
		// nil
	}

	public function onMetadataInventoryTake(pos: EngineVector3, listName: String, index: Int, stack: ItemStack, player: Null<ObjectRefBase>): Void {
		// nil
	}

	public function onBlast(pos: EngineVector3, intensity: Float): Void {
		// nil
	}

	public function new() {
		super();
	}

	@:native("mod_origin")
	public final modOrigin: String = "engineUse";
}
