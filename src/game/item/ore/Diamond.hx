package src.game.item.ore;

import src.engine.definition.ItemDefinition;

@:register("infdev:diamond")
final class Diamond extends ItemDefinition {
	public function new() {
		super();

		this.inventoryImage = "default_diamond.png";
	}
}
