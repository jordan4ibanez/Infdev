package src.game.node;

import src.engine.definition.graphics.RGBA;
import src.engine.definition.graphics.TileAnimationDefinition.TileAnimationDefinitionVerticalFrames;
import src.engine.definition.basic.NodeDropTable;
import src.engine.definition.ToolCapabilities.GroupCapabilities;
import src.engine.definition.basic.TileDefinition;
import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:sandstone")
final class Sandstone extends NodeDefinition {
	public function new() {
		super();

		tiles = ["default_sandstone.png"];
		nodeGroups = [
			NodeGroupStone => 1
		];
	}
}

@:register("infdev:sand")
final class Sand extends NodeDefinition {
	public function new() {
		super();

		tiles = ["default_sand.png"];

		nodeGroups = [
			NodeGroupSand => 1
		];
	}
}

@:register("infdev:bedrock")
final class Bedrock extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 1
		];
		this.tiles = ["default_stone.png^[contrast:100:-15"];
	}
}

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
