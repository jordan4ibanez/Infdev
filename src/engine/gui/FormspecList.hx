package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;

class FormspecList extends FormspecElement {
	var inventoryLocation: String;
	var listName: String;
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.

	public function new(x: Float, y: Float, width: Float, height: Float) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;

        // todo: fixme
		// this.style = new FormspecLabelStyle();
	}

	public function toFormspec(name: String): String {
		return 'list[<inventory location>;<list name>;${this.x},${this.y};${this.width},${this.height};<starting item index>]';
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
