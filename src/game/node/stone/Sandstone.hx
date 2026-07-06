package src.game.node.stone;

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

		this.nodeSounds = StoneSound.get();
	}
}
