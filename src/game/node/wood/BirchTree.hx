package src.game.node.wood;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:birch_tree")
final class BirchTree extends NodeDefinition {
	public function new() {
		super();

		this.description = "Birch Tree";

		this.tiles = [
			"default_aspen_tree_top.png",
			"default_aspen_tree_top.png",
			"default_aspen_tree.png"
		];

		this.paramtype2 = ParamType2FaceDir;

		this.isGroundContent = false;

		this.nodeGroups = [
			NodeGroupWood => 1,
			NodeGroupTree => 1
		];

		this.nodeSounds = WoodSound.get();
	}
}
