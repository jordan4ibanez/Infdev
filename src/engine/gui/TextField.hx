package src.engine.gui;

import src.engine.gui.Gui.GuiElement;
import src.engine.gui.Gui.GuiStyle;
import src.engine.gui.sharedcomponents.FormspecAlignment.FormspecHorizontalAlignment;
import src.engine.gui.sharedcomponents.FormspecAlignment.FormspecVerticalAlignment;

class TextField extends GuiElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.
	var label: String = ""; // ? Done.
	var defaultText: String = ""; // ? Done.
	// This is automatically disabled because it can be very annoying.
	var closeOnEnter = false;

	public function new(x: Float, y: Float, width: Float, height: Float, ?label: String, ?defaultText: String) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		if (label != null) {
			this.label = label;
		}
		if (defaultText != null) {
			this.defaultText = defaultText;
		}

		this.style = new FieldStyle();
	}

	public function toFormspec(name: String): String {
		var output = "";
		if (!this.closeOnEnter) {
			output += 'field_close_on_enter[${name};false]';
		}
		return output + 'field[${this.x},${this.y};${this.width},${this.height};${name};${this.label};${this.defaultText}]';
	}

	public function setStyle(style: FieldStyle): TextField {
		this.style = style;
		return this;
	}

	public function getStyle(): FieldStyle {
		return cast this.style;
	}

	public function setPos(x: Float, y: Float): TextField {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): TextField {
		this.width = width;
		this.height = height;
		return this;
	}

	public function setLabel(label: String): TextField {
		this.label = label;
		return this;
	}

	public function setDefaultText(defaultText: String): TextField {
		this.defaultText = defaultText;
		return this;
	}

	public function enableCloseOnEnter(): TextField {
		this.closeOnEnter = true;
		return this;
	}

	public function saveText(text: String): TextField {
		this.defaultText = text;
		return this;
	}

	public function saveOnCloseAction(data: String) {
		this.defaultText = data;
	}
}

// todo: just copy paste this into pwdfield
class FieldStyle extends GuiStyle {
	var border: Bool; // ! Done
	var font: String; // ! Done
	var fontSize: Float; // ! Done
	var noclip: Bool; // ! Done
	var textColor: String; // ! Done
	var horizontalAlignment: FormspecHorizontalAlignment; // ! Done
	var verticalAlignment: FormspecVerticalAlignment; // ! Done

	public function new() {
		this.setFontSize();
	}

	public function toFormspec(name: String, windowScale: Float): String {
		append('style[${name}');
		if (border != null) {
			append('border=${this.border}');
		}
		if (font != null) {
			append('font=${this.font}');
		}
		if (fontSize != null) {
			append('font_size=${this.fontSize * windowScale}');
		}
		if (noclip != null) {
			append('noclip=${this.noclip}');
		}
		if (this.textColor != null) {
			append('textcolor=${this.textColor}');
		}
		if (horizontalAlignment != null) {
			append('halign=${this.horizontalAlignment}');
		}
		if (verticalAlignment != null) {
			append('valign=${this.verticalAlignment}');
		}

		// And finally close out the string.
		append("]", true);

		// Then swap and clear.
		var output = data;
		data = "";

		return output;
	}

	public function setBorder(border: Bool): FieldStyle {
		this.border = border;
		return this;
	}

	public function setFont(font: String): FieldStyle {
		this.font = font;
		return this;
	}

	public function setFontSize(?fontSize: Float): FieldStyle {
		if (fontSize == null) {
			this.fontSize = GuiStyle.FONT_SIZE_DEFAULT;
		} else {
			this.fontSize = fontSize;
		}
		return this;
	}

	public function setNoclip(noclip: Bool): FieldStyle {
		this.noclip = noclip;
		return this;
	}

	public function setTextColor(textColor: String): FieldStyle {
		this.textColor = textColor;
		return this;
	}

	public function setHorizontalAlign(horizontalAlign: FormspecHorizontalAlignment): FieldStyle {
		this.horizontalAlignment = horizontalAlign;
		return this;
	}

	public function setVerticalAlign(verticalAlign: FormspecVerticalAlignment): FieldStyle {
		this.verticalAlignment = verticalAlign;
		return this;
	}
}
