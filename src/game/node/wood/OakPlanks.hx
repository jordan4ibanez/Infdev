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

		this.recipesShaped = [
			{
				recipe: [
					["infdev:tree", "infdev:tree", "infdev:tree"]
				],
				replacements: [
					"test" => "test"
				]
			}
		];

		this.recipesShapeless = [
			{
				recipe: ["toast", "butter", "ketchup"],
				replacements: [
					"ketchup" => "jam"
				],
				amount: 100
			}
		];

		this.recipesCooking = [
			{
				// You cook coal to get planks.
				recipe: "infdev:coal"
			}
		];

		this.recipeFuel = {
			burntime: 3
		};
	}
}
