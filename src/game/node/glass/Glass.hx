package src.game.node.glass;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:glass")
final class Glass extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupGlass => 1
		];

		this.description = "Glass";

		this.nodeSounds = GlassSound.get();

		this.drawType = DrawTypeGlassLikeFramedOptional;

		this.tiles = [
			"default_glass.png",
			"default_glass_detail.png"
		];

		this.useTextureAlpha = NodeTextureAlphaClip;

		this.paramtype1 = ParamType1Light;

		this.sunlightPropagates = true;
		this.isGroundContent = false;
	}
}
