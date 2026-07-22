package src.game.node.dirt;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:clay_block")
final class ClayBlock extends NodeDefinition {
	public function new() {
		super();

		this.description = "Clay Block";

		this.nodeGroups = [
			NodeGroupSoil => 1,
		];

		this.nodeSounds = DirtSound.get();

		this.tiles = ["default_clay.png"];
	}
}
