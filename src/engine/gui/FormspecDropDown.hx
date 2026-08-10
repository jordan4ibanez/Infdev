package src.engine.gui;

import haxe.Rest;
import src.engine.gui.Formspec.FormspecElement;

class FormspecDropDown extends FormspecElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.

	// Items are a fixed size because I don't even want to think about making
	// tabs dynamic. That sounds horrifying.
	var items: String = "";

	public function new(x: Float, y: Float, width: Float, height: Float, firstItem: String, restOfItems: Rest<String>) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;

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
		return 'dropdown[${this.x},${this.y};${this.width},${this.height};${name};${this.items};<selected idx>;<index event>]';
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
