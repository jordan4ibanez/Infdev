package src.game.node;

import src.engine.definition.graphics.RGBA;
import src.engine.definition.graphics.TileAnimationDefinition.TileAnimationDefinitionVerticalFrames;
import src.engine.definition.basic.NodeDropTable;
import src.engine.definition.ToolCapabilities.GroupCapabilities;
import src.engine.definition.basic.TileDefinition;
import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:water_flow")
final class WaterFlow extends NodeDefinition {
	public function new() {
		super();

		description = "Flowing Water";
		drawType = DrawTypeFlowingLiquid;
		waving = WavingTypeLiquids;
		tiles = ["default_water.png"];
		specialTiles = [
			new TileDefinition("default_water_flowing_animated.png")
				.setBackfaceCulling(false)
				.setAnimation(new TileAnimationDefinitionVerticalFrames(16, 16, 0.5)),
			new TileDefinition("default_water_flowing_animated.png")
				.setBackfaceCulling(true)
				.setAnimation(new TileAnimationDefinitionVerticalFrames(16, 16, 0.5))
		];

		// use_texture_alpha = "blend",
		useTextureAlpha = NodeTextureAlphaBlend;

		// paramtype = "light",
		paramtype1 = ParamType1Light;

		// paramtype2 = "flowingliquid",
		paramtype2 = ParamType2FlowingLiquid;

		// walkable = false,
		walkable = false;

		// pointable = false,
		pointable = false;

		// diggable = false,
		diggable = false;

		// buildable_to = true,
		buildableTo = true;

		// is_ground_content = false,
		isGroundContent = false;

		// drop = "",
		drop = "";

		// drowning = 1,
		drowning = 1;

		// liquidtype = "flowing",
		liquidType = LiquidTypeFlowing;

		// liquid_alternative_flowing = "infdev:water_flowing",
		liquidAlternativeFlowing = "infdev:water_flow";

		// liquid_alternative_source = "infdev:water_source",
		liquidAlternativeSource = "infdev:water_source";

		liquidViscosity = 1;
		postEffectColor = new RGBA(30, 60, 90, 103);
		nodeGroups = [
			NodeGroupLiquidFlow => 1,
			NodeGroupWater => 1
		];

		// -- sounds = default.node_sound_water_defaults(),
	}
}
