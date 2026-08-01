package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;
import src.engine.gui.Formspec.FormspecStyle;
import src.engine.vector.Vec2;

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

// todo: use this on: button, button_exit, image_button, item_image_button
class FormspecButtonStyle extends FormspecStyle {
	var alpha: Bool; // boolean, whether to draw alpha in bgimg. Default true.
	var bgcolor: String; // color, sets button tint.
	var bgimg: String; // standard background image. Defaults to none.
	var font: String; // Sets font type. This is a comma separated list of options. Valid options:
	var font_size: Float; // Sets font size. Default is user//set. Can have multiple values:
	var border: Bool; // boolean, draw border. Set to false to hide the bevelled button pane. Default true.
	var content_offset: Vec2; // 2d vector, shifts the position of the button's content without resizing it.
	var noclip: Bool; // boolean, set to true to allow the element to exceed formspec bounds.
	var padding: Vec2; // rect, adds space between the edges of the button and the content. This value is relative to bgimg_middle.
	var sound: String; // a sound to be played when triggered.
	var textcolor: String; // color, default white.

	public function toFormspec(name: String, windowScale: Float): String {
		throw new haxe.exceptions.NotImplementedException();
	}
}
