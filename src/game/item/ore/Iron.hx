package src.game.item.ore;

import src.engine.definition.ItemDefinition;

@:register("infdev:iron")
final class Iron extends ItemDefinition {
	public function new() {
		super();

		this.description = "Iron Ore";

		this.inventoryImage = "default_iron_lump.png";
	}
}
