package src.game.node.liquid;

import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.TileDefinition;
import src.engine.definition.graphics.RGBA;
import src.engine.definition.graphics.TileAnimationDefinition.TileAnimationDefinitionVerticalFrames;
import src.game.groups.NodeGroup;

@:register("infdev:water_source")
final class WaterSource extends NodeDefinition {
	public function new() {
		super();

		this.tiles = [
			new TileDefinition("default_water_source_animated.png")
				.setAnimation(new TileAnimationDefinitionVerticalFrames(16, 16, 2.0))
				.setBackfaceCulling(false),
			new TileDefinition("default_water_source_animated.png")
				.setBackfaceCulling(true)
				.setAnimation(new TileAnimationDefinitionVerticalFrames(16, 16, 2.0))
		];

		// trace("I am mac osx aqua");

		this.description = "Water Source";
		this.drawType = DrawTypeLiquid;
		this.waving = WavingTypeLiquids;
		this.useTextureAlpha = NodeTextureAlphaBlend;
		this.paramtype1 = ParamType1Light;
		this.walkable = false;
		this.pointable = false;
		this.diggable = false;
		this.buildableTo = true;
		this.isGroundContent = false;
		this.drop = "";
		this.drowning = 1;
		this.liquidType = LiquidTypeSource;
		this.liquidAlternativeFlowing = "infdev:water_flow";
		this.liquidAlternativeSource = "infdev:water_source";
		this.liquidViscosity = 1;
		this.postEffectColor = new RGBA(30, 60, 90, 103);
		this.nodeGroups = [
			NodeGroupLiquidSource => 1,
			NodeGroupWater => 1
		];
	}
}
