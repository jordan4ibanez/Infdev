package src.game.item;

import src.engine.definition.ItemDefinition;

@:register("infdev:fireclay_brick")
final class FireclayBrick extends ItemDefinition {
	public function new() {
		super();

		this.description = "Fireclay Brick";

		this.inventoryImage = "default_clay_brick.png^[colorize:#988558:200";

		this.recipesShapeless = [{
			recipe: ["infdev:fireclay_brick_block"],
			amount: 4
		}];

		this.recipesCooking = [
			{
				recipe: "infdev:uncured_fireclay_brick"
			}
		];
	}
}
