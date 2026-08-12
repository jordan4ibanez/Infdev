package src.engine.gui;

import src.engine.gui.Gui.GuiElement;
import src.engine.gui.Gui.GuiStyle;

/*
	This is fucking horrible.
	For customization, as of 12/8/26 there is no:
	- font selection
	- font color
	- font size
	- checkbox button texture

	So before anyone complains about this implementation looking bland they can read this and go fucking
	look at the fucking documentation. No custom fucking checkbox will be implemented.
	This should be out of the box customizable and no fucking additional hackjobs should 
	need to be implemented for a fucking checkbox.
 */
class CheckBox extends GuiElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var label: String; // ? Done.
	var selected: Bool; // ? Done.

	public function new(x: Float, y: Float, label: String, selected: Bool) {
		this.x = x;
		this.y = y;
		this.label = label;
		this.selected = selected;
	}

	public function toFormspec(name: String): String {
		return 'checkbox[${this.x},${this.y};${name};${this.label};${this.selected}]';
	}

	public function setStyle(style: CheckBoxStyle): CheckBox {
		this.style = style;
		return this;
	}

	public function getStyle(): CheckBoxStyle {
		return cast this.style;
	}

	public function setPos(x: Float, y: Float): CheckBox {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setLabel(label: String): CheckBox {
		this.label = label;
		return this;
	}

	public function setSelected(selected: Bool): CheckBox {
		this.selected = selected;
		return this;
	}

	// No-op.
	public function saveOnCloseAction(data: String) {}
}

class CheckBoxStyle extends GuiStyle {
	var sound: String; // !

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

	public function setSound(sound: String): CheckBoxStyle {
		this.sound = sound;
		return this;
	}
}
