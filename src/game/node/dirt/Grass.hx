package src.game.node;

import src.engine.definition.basic.TileDefinition;
import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

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
