package src.game.item;

import src.engine.definition.ItemDefinition;
import src.game.groups.ItemGroup;
import src.game.groups.NodeGroup;

@:register("infdev:stick")
final class Stick extends ItemDefinition {
	public function new() {
		super();

		this.inventoryImage = "default_stick.png";

		// this.pointabilities = new ItemPointabilitiesTable()
		// 	.setNodes(new ItemPointableMap()
		// 		.set("infdev:dirt", ItemPointableTrue)
		// 		.set("infdev:sand", ItemPointableBlocking));

		this.itemGroups = [
			ItemGroupStick => 1,
			ItemGroupWood => 1,
		];

		this.recipesShaped = [
			{
				recipe: [
					[NodeGroupPlanks.groupify()],
					[NodeGroupPlanks.groupify()]
				],
				amount: 4
			}
		];

		this.recipeFuel = {
			burntime: 3
		}
	}
}
