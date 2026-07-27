package src.game.item.ore;

import src.engine.definition.ItemDefinition;

@:register("infdev:lapis")
final class Lapis extends ItemDefinition {
	public function new() {
		super();

		this.description = "Lapis Lazuli";

		this.inventoryImage = "((default_coal_lump.png^[invert:rgb)^[contrast:100:-70)^[colorize:darkblue:150";
	}
}
