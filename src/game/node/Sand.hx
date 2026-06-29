package src.game.node;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

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
