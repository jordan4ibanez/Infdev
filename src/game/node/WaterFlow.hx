package src.game.node;

import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.TileDefinition;
import src.engine.definition.graphics.RGBA;
import src.engine.definition.graphics.TileAnimationDefinition.TileAnimationDefinitionVerticalFrames;
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
		useTextureAlpha = NodeTextureAlphaBlend;
		paramtype1 = ParamType1Light;
		paramtype2 = ParamType2FlowingLiquid;
		walkable = false;
		pointable = false;
		diggable = false;
		buildableTo = true;
		isGroundContent = false;
		drop = "";
		drowning = 1;
		liquidType = LiquidTypeFlowing;
		liquidAlternativeFlowing = "infdev:water_flow";
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
