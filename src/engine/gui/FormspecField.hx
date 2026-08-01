package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;
import src.engine.gui.Formspec.FormspecStyle;

class FormspecField extends FormspecElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.
	var label: String; // ? Done.
	var defaultText: String = ""; // ? Done.

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

	public function setStyle(style: FormspecFieldStyle): FormspecField {
		this.style = style;
		return this;
	}

	public function setPos(x: Float, y: Float): FormspecField {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): FormspecField {
		this.width = width;
		this.height = height;
		return this;
	}

	public function setLabel(label: String): FormspecField {
		this.label = label;
		return this;
	}

	public function setDefaultText(defaultText: String): FormspecField {
		this.defaultText = defaultText;
		return this;
	}
}

// todo: just copy paste this into pwdfield and textarea
class FormspecFieldStyle extends FormspecStyle {
	public function new() {}

	public function toFormspec(name: String, windowScale: Float): String {
		throw new haxe.exceptions.NotImplementedException();
	}
}
