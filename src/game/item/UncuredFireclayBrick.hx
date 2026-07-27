package src.game.item;

import src.engine.definition.ItemDefinition;

@:register("infdev:uncured_fireclay_brick")
final class UncuredFireclayBrick extends ItemDefinition {
	public function new() {
		super();

		this.description = "Uncured Fireclay Brick";

		this.inventoryImage = "default_clay_brick.png^[colorize:#FBF2C7:200";

		this.recipesShaped = [
			{
				recipe: [
					["infdev:sand", "infdev:clay"],
					["infdev:clay", "infdev:sand"],
				],
				amount: 2
			}
		];
	}
}
