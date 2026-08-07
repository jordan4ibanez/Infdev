package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;

class FormspecList extends FormspecElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.

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
