package src.engine.gui;

import src.engine.gui.Gui.GuiElement;

class List extends GuiElement {
	var inventoryLocation: String;
	var listName: String;
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.
	var startingIndex: Int = 0;

	// todo: when #17305 is merged implement a default texture and then the ability to set custom textures

	public function new(inventoryLocation: String, listName: String, x: Float, y: Float, width: Float, height: Float, ?startingIndex: Int) {
		this.inventoryLocation = inventoryLocation;
		this.listName = listName;
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;

		if (startingIndex != null) {
			this.startingIndex = startingIndex;
		}
	}

	public function toFormspec(name: String): String {
		return 'list[${this.inventoryLocation};${this.listName};${this.x},${this.y};${this.width},${this.height};${this.startingIndex}]';
	}

	public function setInventoryLocation(inventoryLocation: String): List {
		this.inventoryLocation = inventoryLocation;
		return this;
	}

	public function setListName(listName: String): List {
		this.listName = listName;
		return this;
	}

	public function setPos(x: Float, y: Float): List {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): List {
		this.width = width;
		this.height = height;
		return this;
	}
}
