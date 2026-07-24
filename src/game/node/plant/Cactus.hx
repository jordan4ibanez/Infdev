package src.game.node.plant;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:cactus")
final class Cactus extends NodeDefinition {
	public function new() {
		super();

		this.description = "Cactus";

		this.tiles = [
			"default_cactus_top.png",
			"default_cactus_top.png",
			"default_cactus_side.png"
		];

		this.nodeGroups = [
			NodeGroupPlant => 1
		];

		this.nodeSounds = PlantSound.get();
	}
}
