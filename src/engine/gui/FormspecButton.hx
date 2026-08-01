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
	var alpha: Bool; // !
	var backgroundColor: String; // !
	var backgroundImage: String; // !
	var font: String; // !
	var fontSize: Float; // !
	var border: Bool; // !
	var contentOffset: Vec2; // !
	var noclip: Bool; // !
	var padding: Vec2; // !
	var sound: String; // !
	var textColor: String; // !

	public function toFormspec(name: String, windowScale: Float): String {
		append('style[${name}');

		if (this.alpha != null) {
			append('alpha=${this.border}');
		}
		if (this.backgroundColor != null) {
			append('bgcolor=${this.backgroundColor}');
		}
		if (this.backgroundImage != null) {
			append('bgimg=${this.backgroundImage}');
		}
		if (this.font != null) {
			append('font=${this.font}');
		}
		if (this.fontSize != null) {
			append('font_size=${this.fontSize}');
		}
		if (this.border != null) {
			append('border=${this.border}');
		}
		if (this.contentOffset != null) {
			append('content_offset=${this.contentOffset.x},${this.contentOffset.y}');
		}
		if (this.noclip != null) {
			append('noclip=${this.noclip}');
		}
		if (this.padding != null) {
			append('padding=${this.padding.x},${this.padding.y}');
		}
		if (this.sound != null) {
			append('sound=${this.sound}');
		}
		if (this.textColor != null) {
			append('textcolor=${this.textColor}');
		}

		// And finally close out the string.
		append("]", true);

		// Then swap and clear.
		var output = data;
		data = "";

		return output;
	}

	public function setAlpha(alpha: Bool): FormspecButtonStyle {
		this.alpha = alpha;
		return this;
	}

	public function setBackgroundColor(backgroundColor: String): FormspecButtonStyle {
		this.backgroundColor = backgroundColor;
		return this;
	}

	public function setBackgroundImage(backgroundImage: String): FormspecButtonStyle {
		this.backgroundImage = backgroundImage;
		return this;
	}

	public function setFont(font: String): FormspecButtonStyle {
		this.font = font;
		return this;
	}

	public function setFontSize(fontSize: Float): FormspecButtonStyle {
		this.fontSize = fontSize;
		return this;
	}

	public function setBorder(border: Bool): FormspecButtonStyle {
		this.border = border;
		return this;
	}

	public function setContentOffset(x: Float, y: Float): FormspecButtonStyle {
		this.contentOffset = new Vec2(x, y);
		return this;
	}

	public function setNoclip(noclip: Bool): FormspecButtonStyle {
		this.noclip = noclip;
		return this;
	}

	public function setPadding(x: Float, y: Float): FormspecButtonStyle {
		this.padding = new Vec2(x, y);
		return this;
	}

	public function setSound(sound: String): FormspecButtonStyle {
		this.sound = sound;
		return this;
	}

	public function setTextColor(textColor: String): FormspecButtonStyle {
		this.textColor = textColor;
		return this;
	}
}
