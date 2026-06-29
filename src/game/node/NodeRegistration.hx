package src.game.node;

import src.engine.definition.graphics.RGBA;
import src.engine.definition.graphics.TileAnimationDefinition.TileAnimationDefinitionVerticalFrames;
import src.engine.definition.basic.NodeDropTable;
import src.engine.definition.ToolCapabilities.GroupCapabilities;
import src.engine.definition.basic.TileDefinition;
import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;


@:register("infdev:water_source")
final class WaterSource extends NodeDefinition {
	public function new() {
		super();

		tiles = [
			new TileDefinition("default_water_source_animated.png")
				.setAnimation(new TileAnimationDefinitionVerticalFrames(16, 16, 2.0))
				.setBackfaceCulling(false),
			new TileDefinition("default_water_source_animated.png")
				.setBackfaceCulling(true)
				.setAnimation(new TileAnimationDefinitionVerticalFrames(16, 16, 2.0))
		];

		// trace("I am mac osx aqua");

		description = "Water Source";
		drawType = DrawTypeLiquid;
		waving = WavingTypeLiquids;
		useTextureAlpha = NodeTextureAlphaBlend;
		paramtype1 = ParamType1Light;

		walkable = false;
		pointable = false;
		diggable = false;
		buildableTo = true;
		isGroundContent = false;
		drop = "";
		drowning = 1;
		liquidType = LiquidTypeSource;
		liquidAlternativeFlowing = "infdev:water_flow";
		liquidAlternativeSource = "infdev:water_source";
		liquidViscosity = 1;
		postEffectColor = new RGBA(30, 60, 90, 103);
		nodeGroups = [
			NodeGroupLiquidSource => 1,
			NodeGroupWater => 1
		];
	}
}
