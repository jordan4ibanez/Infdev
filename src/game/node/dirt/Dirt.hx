package src.game.node.dirt;

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
