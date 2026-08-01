package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;
import src.engine.gui.Formspec.FormspecStyle;

class FormspecButton extends FormspecElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.
	var label: String; // ? Done.

	public function new(x: Float, y: Float, width: Float, height: Float, label: String) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.label = label;
	}

	public function toFormspec(name: String): String {
		return 'button[${this.x},${this.y};${this.width},${this.height};${name};${this.label}]';
	}

	public function setStyle(style: FormspecButtonStyle): FormspecButton {
		this.style = style;
		return this;
	}

	public function setPos(x: Float, y: Float): FormspecButton {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): FormspecButton {
		this.width = width;
		this.height = height;
		return this;
	}

	public function setLabel(label: String): FormspecButton {
		this.label = label;
		return this;
	}
}

class FormspecButtonStyle extends FormspecStyle {
	public function toFormspec(name: String, windowScale: Float): String {
		throw new haxe.exceptions.NotImplementedException();
	}
}
