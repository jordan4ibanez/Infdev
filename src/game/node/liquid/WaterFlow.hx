package src.game.node.liquid;

import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.TileDefinition;
import src.engine.definition.graphics.RGBA;
import src.engine.definition.graphics.TileAnimationDefinition.TileAnimationDefinitionVerticalFrames;
import src.game.groups.NodeGroup;

@:register("infdev:water_flow")
final class WaterFlow extends NodeDefinition {
	public function new() {
		super();

		this.description = "Flowing Water";
		this.drawType = DrawTypeFlowingLiquid;
		this.waving = WavingTypeLiquids;
		this.tiles = ["default_water.png"];
		this.specialTiles = [
			new TileDefinition("default_water_flowing_animated.png")
				.setBackfaceCulling(false)
				.setAnimation(new TileAnimationDefinitionVerticalFrames(16, 16, 0.5)),
			new TileDefinition("default_water_flowing_animated.png")
				.setBackfaceCulling(true)
				.setAnimation(new TileAnimationDefinitionVerticalFrames(16, 16, 0.5))
		];
		this.useTextureAlpha = NodeTextureAlphaBlend;
		this.paramtype1 = ParamType1Light;
		this.paramtype2 = ParamType2FlowingLiquid;
		this.walkable = false;
		this.pointable = false;
		this.diggable = false;
		this.buildableTo = true;
		this.isGroundContent = false;
		this.drop = "";
		this.drowning = 1;
		this.liquidType = LiquidTypeFlowing;
		this.liquidAlternativeFlowing = "infdev:water_flow";
		this.liquidAlternativeSource = "infdev:water_source";
		this.liquidViscosity = 1;
		this.postEffectColor = new RGBA(30, 60, 90, 103);
		this.nodeGroups = [
			NodeGroupLiquidFlow => 1,
			NodeGroupWater => 1
		];
		// -- sounds = default.node_sound_water_defaults(),
	}
}
