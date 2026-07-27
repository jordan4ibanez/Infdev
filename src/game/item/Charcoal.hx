package src.game.item;

import src.engine.definition.ItemDefinition;
import src.game.groups.NodeGroup;

@:register("infdev:charcoal")
final class Charcoal extends ItemDefinition {
	public function new() {
		super();

		this.inventoryImage = "default_coal_lump.png";

		this.recipesCooking = [
			{
				recipe: NodeGroupTree.groupify()
			}
		];

		this.recipeFuel = {
			burntime: 40
		}
	}
}
