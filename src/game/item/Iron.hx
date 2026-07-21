package src.game.item;

import src.engine.definition.ItemDefinition;

@:register("infdev:iron")
final class Iron extends ItemDefinition {
	public function new() {
		super();

		this.inventoryImage = "default_iron_lump.png";
	}
}
