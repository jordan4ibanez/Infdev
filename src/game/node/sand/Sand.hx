package src.game.node.sand;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:sand")
final class Sand extends NodeDefinition {
	public function new() {
		super();

		this.description = "Sand";

		this.tiles = ["default_sand.png"];

		this.nodeGroups = [
			NodeGroupSand => 1,
			NodeGroupFallingNode => 1,
		];

		this.nodeSounds = SandSound.get();
	}
}
