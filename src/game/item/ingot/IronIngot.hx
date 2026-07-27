package src.game.item.ingot;

import src.engine.definition.ItemDefinition;

@:register("infdev:iron_ingot")
final class IronIngot extends ItemDefinition {
	public function new() {
		super();

		this.description = "Iron Ingot";

		this.inventoryImage = "default_steel_ingot.png";

		this.recipesCooking = [
			{
				recipe: "infdev:iron"
			}
		];
	}
}
