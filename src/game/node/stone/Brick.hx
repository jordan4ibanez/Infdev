package src.game.node.stone;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:brick")
final class Brick extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 2
		];

		this.nodeSounds = StoneSound.get();

		this.tiles = ["default_brick.png"];
	}
}
