package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;

class FormspecList extends FormspecElement {
	var inventoryLocation: String;
	var listName: String;
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.
	var startingIndex: Int = 1;

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

	public function setInventoryLocation(inventoryLocation: String): FormspecList {
		this.inventoryLocation = inventoryLocation;
		return this;
	}

	public function setListName(listName: String): FormspecList {
		this.listName = listName;
		return this;
	}

	public function setPos(x: Float, y: Float): FormspecList {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): FormspecList {
		this.width = width;
		this.height = height;
		return this;
	}
}
