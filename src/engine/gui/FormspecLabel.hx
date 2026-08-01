package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;
import src.engine.gui.Formspec.FormspecStyle;
import src.engine.gui.sharedcomponents.FormspecAlignment.FormspecHorizontalAlignment;
import src.engine.gui.sharedcomponents.FormspecAlignment.FormspecVerticalAlignment;

class FormspecLabel extends FormspecElement {
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
		return 'label[${this.x},${this.y};${this.width},${this.height};${this.label}]';
	}

	public function setStyle(style: FormspecLabelStyle): FormspecLabel {
		this.style = style;
		return this;
	}

	public function setPos(x: Float, y: Float): FormspecLabel {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): FormspecLabel {
		this.width = width;
		this.height = height;
		return this;
	}

	public function setLabel(label: String): FormspecLabel {
		this.label = label;
		return this;
	}
}

/**
 * This is very weird and will act weird.
 * For every label you use it will inherit the previous styling and it is random.
 * So if any labels are styled, style them all.
 */
class FormspecLabelStyle extends FormspecStyle {
	var font: String; // ? Done
	var fontSize: Int; // ? Done
	var noclip: Bool; // ? Done
	var horizontalAlign: FormspecHorizontalAlignment; // ? Done
	var verticalAlign: FormspecVerticalAlignment; // ? Done

	public function new() {}

	public function toFormspec(name: String, windowScale: Float): String {
		append('style_type[label');
		if (font != null) {
			append('font=*${this.font}');
		}
		if (fontSize != null) {
			append('font_size=${this.fontSize * windowScale}');
		}
		if (noclip != null) {
			append('noclip=${this.noclip}');
		}
		if (horizontalAlign != null) {
			append('halign=${this.horizontalAlign}');
		}
		if (verticalAlign != null) {
			append('valign=${this.verticalAlign}');
		}

		// And finally close out the string.
		append("]", true);

		// Then swap and clear.
		var output = data;
		data = "";

		return output;
	}

	public function setFont(font: String): FormspecLabelStyle {
		this.font = font;
		return this;
	}

	public function setFontSize(fontSize: Int): FormspecLabelStyle {
		this.fontSize = fontSize;
		return this;
	}

	public function setNoclip(noclip: Bool): FormspecLabelStyle {
		this.noclip = noclip;
		return this;
	}

	public function setHorizontalAlign(horizontalAlign: FormspecHorizontalAlignment): FormspecLabelStyle {
		this.horizontalAlign = horizontalAlign;
		return this;
	}

	public function setVerticalAlign(verticalAlign: FormspecVerticalAlignment): FormspecLabelStyle {
		this.verticalAlign = verticalAlign;
		return this;
	}
}

// todo: area label, vertical label
