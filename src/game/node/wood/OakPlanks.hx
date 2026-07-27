package src.game.node.wood;

import src.engine.definition.NodeDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:oak_planks")
final class OakPlanks extends NodeDefinition {
	public function new() {
		super();

		this.description = "Oak Planks";

		this.tiles = [
			"default_wood.png"
		];

		this.isGroundContent = false;

		this.nodeGroups = [
			NodeGroupWood => 1,
			NodeGroupPlanks => 1
		];

		this.nodeSounds = WoodSound.get();

		this.recipesShapeless = [
			{
				recipe: ["infdev:oak_tree"],
				amount: 4,
			}
		];

		this.recipeFuel = {
			burntime: 10
		}
	}
}
