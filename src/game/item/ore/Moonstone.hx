package src.game.item.ore;


import src.engine.definition.ItemDefinition;

@:register("infdev:moonstone")
final class Moonstone extends ItemDefinition {
	public function new() {
		super();

		this.description = "Moonstone";

		this.inventoryImage = "((default_coal_lump.png^[invert:rgb)^[contrast:100:-70)^[colorize:lightblue:200";
	}
}
