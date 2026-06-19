package engine.definition;

import engine.entity.objectref.ObjectRefBase;
import engine.vector.EngineVector3;
import engine.definition.images.TileAnimationDefinition;
import haxe.extern.EitherType;
import engine.definition.images.ItemImageDefinition;

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
 * Also another note: This one is for nodes. Use the ItemDefinition class for tools/items.
 */
@:luantiDefinitionRoot
class NodeDefinition extends ItemDefinition {
	// todo: drawtype.
	@:native("drawtype")
	var drawType: Dynamic;

	@:native("visual_scale")
	var visualScale: Float;

	// todo: tile definition
	var tiles: Array<Dynamic>;

	@:native("overlay_tiles")
	var overlayTiles: Array<Dynamic>;

	@:native("special_tiles")
	var specialTiles: Array<Dynamic>;

	/**
	 * This one is for nodes.
	 */
	// todo: ColorSpec.
	@:native("color")
	var nodeColor: Dynamic;

	// todo: NodeTextureAlpha
	@:native("use_texture_alpha")
	var useTextureAlpha: Dynamic;

	@:native("post_effect_color")
	var postEffectColor: String;

	@:native("post_effect_color_shaded")
	var postEffectColorShaded: Bool;

	// todo: ParamType1
	var paramtype: Dynamic;

	// todo: ParamType2
	var paramtype2: Dynamic;

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

	// todo: LiquidType
	var liquidtype: Dynamic;

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

	// todo: NodeBox
	@:native("node_box")
	var nodeBox: Dynamic;

	@:native("connects_to")
	var connectsTo: Array<String>;

	// todo: ConnectSides Enum.
	@:native("connect_sides")
	var connectSides: Array<Dynamic>;

	var mesh: String;

	@:native("selection_box")
	var selectionBox: Dynamic; // todo: this is another nodebox

	@:native("collision_box")
	var collisionBox: Dynamic; // todo: this is another nodebox

	@:native("legacy_facedir_simple")
	var legacyFacedirSimple: Bool;

	@:native("legacy_wallmounted")
	var legacyWallmounted: Bool;

	// todo: WavingType enum.
	var waving: Dynamic;

	/**
	 * This one is for nodes.
	 */
	// todo: NodeSounds
	@:native("sounds")
	var nodeSounds: Dynamic;

	// todo: NodeDrops
	var drop: Dynamic;

	// on_construct
	public function onConstruct(pos: EngineVector3): Void {
		// nil
	}

	// on_destruct
	public function onDestruct(pos: EngineVector3): Void {
		// nil
	}

	// todo: Node thing
	// after_destruct
	public function afterDestruct(pos: EngineVector3, oldNode: Dynamic) {
		// nil
	}

	// on_flood
	public function onFlood(): Bool {
		// nil
		return false;
	}

	// todo: Metadata table
	// preserve_metadata
	public function preserverMetadata(pos: EngineVector3, oldNode: Dynamic, oldMeta: Dynamic, drops: Array<ItemStack>): Void {
		// nil
	}

	// after_place_node
	public function afterPlaceNode(pos: EngineVector3, placer: Null<ObjectRefBase>, itemstack: ItemStack, pointedThing: PointedThing): Bool {
		// nil
		return false;
	}

	// after_dig_node
	public function afterDigNode(pos: EngineVector3, oldNode: Dynamic, oldMetaData: Dynamic, digger: Null<ObjectRefBase>): Void {
		// nil
	}

	// can_dig
	public function canDig(pos: EngineVector3, player: Null<ObjectRefBase>): Bool {
		// nil
		return true;
	}

	// todo: No fucking clue what node is
	// on_punch
	public function onPunch(pos: EngineVector3, node: Dynamic, puncher: Null<ObjectRefBase>, pointedThing: PointedThing): Void {
		// core.register_on_punchnode
	}

	// on_rightclick
	public function onRightClick(pos: EngineVector3, node: Dynamic, clicker: Null<ObjectRefBase>, itemStack: ItemStack, pointedThing: Null<PointedThing>): ItemStack {
		// nil
		return itemStack;
	}

	// on_dig
	public function onDig(pos: EngineVector3, node: Dynamic, digger: Null<ObjectRefBase>): Bool {
		// core.node_dig;
		return Core.nodeDig();
	}

	public function new() {
		super();
	}
}
