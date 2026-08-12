package src.engine.gui;

import src.engine.gui.Gui.GuiElement;
import src.engine.gui.Gui.GuiStyle;
import src.engine.gui.sharedcomponents.FormspecAlignment.FormspecHorizontalAlignment;
import src.engine.gui.sharedcomponents.FormspecAlignment.FormspecVerticalAlignment;

class Label extends GuiElement {
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

		this.style = new LabelStyle();
	}

	public function toFormspec(name: String): String {
		return 'label[${this.x},${this.y};${this.width},${this.height};${this.label}]';
	}

	public function setStyle(style: LabelStyle): Label {
		this.style = style;
		return this;
	}

	public function getStyle(): LabelStyle {
		return cast this.style;
	}

	public function setPos(x: Float, y: Float): Label {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): Label {
		this.width = width;
		this.height = height;
		return this;
	}

	public function setLabel(label: String): Label {
		this.label = label;
		return this;
	}

	// No-op.
	public function saveOnCloseAction(data: Null<String>) {}
}

/**
 * This is very weird and will act weird.
 * For every label you use it will inherit the previous styling and it is random.
 * So if any labels are styled, style them all.
 */
class LabelStyle extends GuiStyle {
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
		append('style_type[label');
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

	public function setFont(font: String): LabelStyle {
		this.font = font;
		return this;
	}

	public function setFontSize(?fontSize: Float): LabelStyle {
		if (fontSize == null) {
			this.fontSize = GuiStyle.FONT_SIZE_DEFAULT;
		} else {
			this.fontSize = fontSize;
		}
		return this;
	}

	public function setNoclip(noclip: Bool): LabelStyle {
		this.noclip = noclip;
		return this;
	}

	public function setTextColor(textColor: String): LabelStyle {
		this.textColor = textColor;
		return this;
	}

	public function setHorizontalAlign(horizontalAlign: FormspecHorizontalAlignment): LabelStyle {
		this.horizontalAlignment = horizontalAlign;
		return this;
	}

	public function setVerticalAlign(verticalAlign: FormspecVerticalAlignment): LabelStyle {
		this.verticalAlignment = verticalAlign;
		return this;
	}
}

// todo: area label, vertical label
