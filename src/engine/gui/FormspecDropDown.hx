package src.engine.gui;

import haxe.Rest;
import src.engine.gui.Formspec.FormspecElement;
import src.engine.gui.Formspec.FormspecStyle;

class FormspecDropDown extends FormspecElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.
	var currentItem: Int;

	// Items are a fixed size because I don't even want to think about making
	// tabs dynamic. That sounds horrifying.
	var items: String = "";

	public function new(x: Float, y: Float, width: Float, height: Float, defaultItem: Int, firstItem: String, restOfItems: Rest<String>) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.currentItem = defaultItem;

		var length = restOfItems.length;

		this.items = firstItem;
		if (length != 0) {
			this.items += ",";
		}

		for (index => item in restOfItems) {
			this.items += item;
			// This may be a mess but I want it to be a nice mess.
			if (index + 1 < length) {
				this.items += ",";
			}
		}
	}

	public function toFormspec(name: String): String {
		return 'dropdown[${this.x},${this.y};${this.width},${this.height};${name};${this.items};${this.currentItem};true]';
	}

	public function setStyle(style: FormspecDropDownStyle): FormspecDropDown {
		this.style = style;
		return this;
	}

	public function getStyle(): FormspecDropDownStyle {
		return cast this.style;
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

class FormspecDropDownStyle extends FormspecStyle {
	var sound: String;

	public function new() {}

	public function toFormspec(name: String, windowScale: Float): String {
		append('style[${name}');

		if (this.sound != null) {
			append('sound=${this.sound}');
		}

		// And finally close out the string.
		append("]", true);

		// Then swap and clear.
		var output = data;
		data = "";

		return output;
	}

	public function setSound(sound: String): FormspecDropDownStyle {
		this.sound = sound;
		return this;
	}
}
