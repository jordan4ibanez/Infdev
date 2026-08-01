package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;

class FormspecField extends FormspecElement {
	var x: Float;
	var y: Float;
	var width: Float;
	var height: Float;
	var label: String;
	var defaultText: String = "";

	public function new(x: Float, y: Float, width: Float, height: Float, label: String, defaultText: String) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.label = label;
		this.defaultText = defaultText;
	}

	public function toFormspec(name: String): String {
		return 'field[${this.x},${this.y};${this.width},${this.height};${name};${this.label};${this.defaultText}]';
	}
}
