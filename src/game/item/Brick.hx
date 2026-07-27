package src.game.item;

import src.engine.definition.ItemDefinition;

@:register("infdev:brick")
final class Brick extends ItemDefinition {
	public function new() {
		super();

		this.description = "Brick";

		this.inventoryImage = "default_clay_brick.png^[colorize:#842020:100";

		this.recipesShapeless = [
			{
				recipe: ["infdev:brick_block"],
				amount: 4
			}
		];
	}
}
