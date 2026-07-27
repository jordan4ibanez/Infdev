package src.game.node.wood;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:birch_planks")
final class BirchPlanks extends NodeDefinition {
	public function new() {
		super();

		this.description = "Birch Planks";

		this.tiles = [
			"default_aspen_wood.png"
		];

		this.isGroundContent = false;

		this.nodeGroups = [
			NodeGroupWood => 1,
			NodeGroupPlanks => 1
		];

		this.nodeSounds = WoodSound.get();

		this.recipesShapeless = [
			{
				recipe: ["infdev:birch_tree"],
				amount: 4,
			}
		];
	}
}
