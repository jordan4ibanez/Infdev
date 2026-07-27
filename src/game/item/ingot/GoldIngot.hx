package src.game.item.ingot;

import src.engine.definition.ItemDefinition;

@:register("infdev:gold_ingot")
final class GoldIngot extends ItemDefinition {
	public function new() {
		super();

		this.description = "Gold Ingot";

		this.inventoryImage = "default_gold_ingot.png";

		this.recipesCooking = [
			{
				recipe: "infdev:gold"
			}
		];
	}
}
