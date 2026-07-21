package src.game.item;

import src.engine.definition.ItemDefinition;
import src.engine.definition.basic.ItemPointabilitiesTable;

@:register("infdev:stick")
final class Stick extends ItemDefinition {
	public function new() {
		super();

		this.inventoryImage = "default_stick.png";

		this.pointabilities = new ItemPointabilitiesTable()
			.setNodes(new ItemPointableMap()
				.set("infdev:dirt", ItemPointableTrue)
				.set("infdev:sand", ItemPointableBlocking));
	}
}
