package src.game.item.ore;

import src.engine.definition.ItemDefinition;

@:register("infdev:emerald")
final class Emerald extends ItemDefinition {
	public function new() {
		super();

		this.description = "Emerald";

		this.inventoryImage = "default_diamond.png^[colorize:lime:190";
	}
}
