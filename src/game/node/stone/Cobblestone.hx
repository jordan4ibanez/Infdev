package src.game.node.stone;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:cobblestone")
final class Cobblestone extends NodeDefinition {
	public function new() {
		super();

		this.description = "Cobblestone";

		this.nodeGroups = [
			NodeGroupStone => 2,
			NodeGroupCobblestone => 2,
		];

		this.nodeSounds = StoneSound.get();

		this.tiles = ["default_cobble.png"];
	}
}
