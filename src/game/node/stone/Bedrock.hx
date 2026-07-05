package src.game.node.stone;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:bedrock")
final class Bedrock extends NodeDefinition {
	public function new() {
		super();

		this.nodeGroups = [
			NodeGroupHandDiggable => BEDROCK
		];
		this.tiles = ["default_stone.png^[contrast:100:-15"];
	}
}
