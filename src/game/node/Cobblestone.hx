package src.game.node;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

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
