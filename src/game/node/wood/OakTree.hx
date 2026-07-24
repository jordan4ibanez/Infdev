package src.game.node.wood;

import src.engine.definition.NodeDefinition;
import src.engine.definition.basic.NodeBox;
import src.game.groups.NodeGroup;

@:register("infdev:oak_tree")
final class OakTree extends NodeDefinition {
	public function new() {
		super();

		this.description = "Oak Tree";

		this.tiles = [
			"default_tree_top.png",
			"default_tree_top.png",
			"default_tree.png"
		];

		this.drawType = DrawTypePlantLike;

		this.paramtype2 = ParamType2FaceDir;

		this.isGroundContent = false;

		this.nodeGroups = [
			NodeGroupWood => 1,
			NodeGroupTree => 1
		];

		this.nodeSounds = WoodSound.get();
	}
}
