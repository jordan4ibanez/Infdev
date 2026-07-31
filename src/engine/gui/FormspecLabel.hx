package src.engine.gui;


class FormspecStyleLabel extends FormspecStyle {
	var font: String; // ? Done
	var fontSize: Int; // ? Done
	var noclip: Bool; // ? Done
	// todo: that's an enum.
	var horizontalAlign: String; // ? Done
	// todo: that's an enum.
	var verticalAlign: String; // ? Done

	public function new() {}

	public function toFormspec(name: String): String {
		append('style[$name');
		if (font != null) {
			append('font=${this.font}');
		}
		if (fontSize != null) {
			append('font_size=${this.fontSize}');
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

	public function setFont(font: String): FormspecStyleLabel {
		this.font = font;
		return this;
	}

	public function setFontSize(fontSize: Int): FormspecStyleLabel {
		this.fontSize = fontSize;
		return this;
	}

	public function setNoclip(noclip: Bool): FormspecStyleLabel {
		this.noclip = noclip;
		return this;
	}

	public function setHorizontalAlign(horizontalAlign: String): FormspecStyleLabel {
		this.horizontalAlign = horizontalAlign;
		return this;
	}

	public function setVerticalAlign(verticalAlign: String): FormspecStyleLabel {
		this.verticalAlign = verticalAlign;
		return this;
	}
}

class FormspecLabel extends FormspecElement {
	var x: Float;
	var y: Float;
	var label: String;

	public function new(x: Float, y: Float, label: String) {
		this.x = x;
		this.y = y;
		this.label = label;
	}

	public function toFormspec(): String {
		return 'label[${this.x},${this.y};${this.label}]';
	}

	public function setStyle(style: FormspecStyleLabel): FormspecLabel {
		this.style = style;
		return this;
	}
}
