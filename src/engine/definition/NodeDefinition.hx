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

	public function new() {
		super();
	}
}
