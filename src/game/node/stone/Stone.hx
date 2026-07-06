package src.game.node.stone;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:stone")
final class Stone extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupStone => 1
		];
		this.tiles = ["default_stone.png"];

		this.nodeSounds = StoneSound.get();

		drop = "infdev:cobblestone";
	}
}
