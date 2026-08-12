package src.engine.gui;

import src.engine.gui.Gui.GuiElement;

class ListRing extends GuiElement {
	var inventoryLocation: String;
	var listName: String;

	public function new(inventoryLocation: String, listName: String) {
		this.inventoryLocation = inventoryLocation;
		this.listName = listName;
	}

	public function toFormspec(name: String): String {
		return 'listring[${this.inventoryLocation};${this.listName}]';
	}
}
