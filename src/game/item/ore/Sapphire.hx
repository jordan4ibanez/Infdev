package src.game.item.ore;

import src.engine.definition.ItemDefinition;

@:register("infdev:sapphire")
final class Sapphire extends ItemDefinition {
	public function new() {
		super();

		this.description = "Sapphire";

		this.inventoryImage = "default_diamond.png^[colorize:blue:190";
	}
}
