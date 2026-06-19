package engine.definition;

import engine.definition.images.TileAnimationDefinition;
import haxe.extern.EitherType;
import engine.definition.images.ItemImageDefinition;

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

	public function new() {
		super();
	}
}
