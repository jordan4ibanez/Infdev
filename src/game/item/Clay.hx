package src.game.item;

import src.engine.definition.ItemDefinition;

@:register("infdev:clay")
final class Clay extends ItemDefinition {
	public function new() {
		super();

		this.description = "Clay";

		this.inventoryImage = "default_clay_lump.png";
	}
}
