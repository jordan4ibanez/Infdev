package src.engine.gui;

import src.engine.gui.Gui.GuiElement;
import src.engine.gui.Gui.GuiStyle;
import src.engine.vector.Vec2;

class TextArea extends GuiElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done.
	var label: String = ""; // ? Done.
	var defaultText: String = ""; // ? Done.

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

		// Text areas are basically useless without default persistence.
		this.setPersistent(true);

		this.style = new TextAreaStyle();
	}

	public function toFormspec(name: String): String {
		return 'textarea[${this.x},${this.y};${this.width},${this.height};${name};${this.label};${this.defaultText}]';
	}

	public function setStyle(style: TextAreaStyle): TextArea {
		this.style = style;
		return this;
	}

	public function getStyle(): TextAreaStyle {
		return cast this.style;
	}

	public function setPos(x: Float, y: Float): TextArea {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): TextArea {
		this.width = width;
		this.height = height;
		return this;
	}

	public function setLabel(label: String): TextArea {
		this.label = label;
		return this;
	}

	public function setDefaultText(defaultText: String): TextArea {
		this.defaultText = defaultText;
		return this;
	}

	public function saveOnCloseAction(data: Null<String>) {
		if (data == null) {
			return;
		}
		this.defaultText = data;
	}
}

class TextAreaStyle extends GuiStyle {
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

	public function new() {
		this.setFontSize();
	}

	public function toFormspec(name: String, windowScale: Float): String {
		append('style[${name}');

		if (this.alpha != null) {
			append('alpha=${this.alpha}');
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
			append('font_size=${this.fontSize * windowScale}');
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

	public function setAlpha(alpha: Bool): TextAreaStyle {
		this.alpha = alpha;
		return this;
	}

	public function setBackgroundColor(backgroundColor: String): TextAreaStyle {
		this.backgroundColor = backgroundColor;
		return this;
	}

	public function setBackgroundImage(backgroundImage: String): TextAreaStyle {
		this.backgroundImage = backgroundImage;
		return this;
	}

	public function setFont(font: String): TextAreaStyle {
		this.font = font;
		return this;
	}

	public function setFontSize(?fontSize: Float): TextAreaStyle {
		if (fontSize == null) {
			this.fontSize = GuiStyle.FONT_SIZE_DEFAULT;
		} else {
			this.fontSize = fontSize;
		}
		return this;
	}

	public function setBorder(border: Bool): TextAreaStyle {
		this.border = border;
		return this;
	}

	public function setContentOffset(x: Float, y: Float): TextAreaStyle {
		this.contentOffset = new Vec2(x, y);
		return this;
	}

	public function setNoclip(noclip: Bool): TextAreaStyle {
		this.noclip = noclip;
		return this;
	}

	public function setPadding(x: Float, y: Float): TextAreaStyle {
		this.padding = new Vec2(x, y);
		return this;
	}

	public function setSound(sound: String): TextAreaStyle {
		this.sound = sound;
		return this;
	}

	public function setTextColor(textColor: String): TextAreaStyle {
		this.textColor = textColor;
		return this;
	}
}
