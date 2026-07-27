package src.game.item.ore;

import src.engine.definition.ItemDefinition;

@:register("infdev:ruby")
final class Ruby extends ItemDefinition {
	public function new() {
		super();

		this.description = "Ruby";

		this.inventoryImage = "default_diamond.png^[colorize:red:190";
	}
}
