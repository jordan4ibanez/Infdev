package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;

/**
 * When clicked, fields will be sent and the form will quit.
 * Same as `button` in all other respects.
 */
class FormspecButtonExit extends FormspecElement {
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

		this.style = new FormspecButtonStyle();
	}

	public function toFormspec(name: String): String {
		return 'button[${this.x},${this.y};${this.width},${this.height};${name};${this.label}]';
	}

	public function setStyle(style: FormspecButtonStyle): FormspecButtonExit {
		this.style = style;
		return this;
	}

	public function getStyle(): FormspecButtonStyle {
		return cast this.style;
	}

	public function setPos(x: Float, y: Float): FormspecButtonExit {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): FormspecButtonExit {
		this.width = width;
		this.height = height;
		return this;
	}

	public function setLabel(label: String): FormspecButtonExit {
		this.label = label;
		return this;
	}
}
