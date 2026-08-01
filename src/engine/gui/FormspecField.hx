package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;
import src.engine.gui.Formspec.FormspecStyle;
import src.engine.gui.sharedcomponents.FormspecAlignment.FormspecHorizontalAlignment;
import src.engine.gui.sharedcomponents.FormspecAlignment.FormspecVerticalAlignment;

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
	var border: Bool; // ? Done
	var font: String; // ? Done
	var fontSize: Float; // ? Done
	var noclip: Bool; // ? Done
	var textColor: String; // ? Done
	var horizontalAlignment: FormspecHorizontalAlignment; // ? Done
	var verticalAlignment: FormspecVerticalAlignment; // ? Done

	public function new() {}

	public function toFormspec(name: String, windowScale: Float): String {
		throw new haxe.exceptions.NotImplementedException();
	}

	public function setBorder(border: Bool): FormspecFieldStyle {
		this.border = border;
		return this;
	}

	public function setFont(font: String): FormspecFieldStyle {
		this.font = font;
		return this;
	}

	public function setFontSize(fontSize: Int): FormspecFieldStyle {
		this.fontSize = fontSize;
		return this;
	}

	public function setNoclip(noclip: Bool): FormspecFieldStyle {
		this.noclip = noclip;
		return this;
	}

	public function setTextureColor(textColor: String): FormspecFieldStyle {
		this.textColor = textColor;
		return this;
	}

	public function setHorizontalAlign(horizontalAlign: FormspecHorizontalAlignment): FormspecFieldStyle {
		this.horizontalAlignment = horizontalAlign;
		return this;
	}

	public function setVerticalAlign(verticalAlign: FormspecVerticalAlignment): FormspecFieldStyle {
		this.verticalAlignment = verticalAlign;
		return this;
	}
}
