package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;

class FormspecDropDown extends FormspecElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.

	public function new() {}

	public function toFormspec(name: String): String {
		return 'dropdown[${this.x},${this.y};${this.width},${this.height};${name};<item 1>,<item 2>, ...,<item n>;<selected idx>;<index event>]';
	}

	public function setPos(x: Float, y: Float): FormspecDropDown {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): FormspecDropDown {
		this.width = width;
		this.height = height;
		return this;
	}
}
