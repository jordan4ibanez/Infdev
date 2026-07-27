package src.game.item.ore;

import src.engine.definition.ItemDefinition;

@:register("infdev:coal")
final class Coal extends ItemDefinition {
	public function new() {
		super();

		this.description = "Coal";

		this.inventoryImage = "default_coal_lump.png^[colorize:black:170";

		this.recipeFuel = {
			burntime: 45
		}
	}
}
