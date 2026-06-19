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

	public function new() {
		super();
	}
}
