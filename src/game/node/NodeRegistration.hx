package src.game.node;

import src.engine.definition.basic.NodeDropTable;
import src.engine.definition.ToolCapabilities.GroupCapabilities;
import src.engine.definition.basic.TileDefinition;
import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:dirt")
final class Dirt extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupDirt => 1
		];

		tiles = ["default_dirt.png"];
	}
}

@:register("infdev:grass")
final class Grass extends NodeDefinition {
	public function new() {
		super();

		tiles = [
			"default_grass.png",
			"default_dirt.png",
			new TileDefinition("default_dirt.png^default_grass_side.png")
				.setTileableHorizontal(false)
		];

		nodeGroups = [
			NodeGroupSoil => 1
		];

		this.drop = "infdev:dirt";
	}
}

@:register("infdev:stone")
final class Stone extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 1
		];
		this.tiles = ["default_stone.png"];

		drop = "infdev:cobblestone";
	}
}

@:register("infdev:cobblestone")
final class Cobblestone extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 1
		];
		this.tiles = ["default_cobble.png"];
	}
}

@:register("infdev:water_source")
final class WaterSource extends NodeDefinition {
	public function new() {
		super();

		// trace("I am aqua");
	}
}

@:register("infdev:sandstone")
final class Sandstone extends NodeDefinition {
	public function new() {
		super();
	}
}

@:register("infdev:sand")
final class Sand extends NodeDefinition {
	public function new() {
		super();
	}
}

@:register("infdev:bedrock")
final class Bedrock extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 1
		];
		this.tiles = ["default_stone.png"];

		this.nodeColor = "black";
	}
}
