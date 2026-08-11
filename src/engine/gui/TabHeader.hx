package src.engine.gui;

import src.engine.gui.Gui.FormspecElement;
import src.engine.gui.Gui.FormspecStyle;

// This is a simple helper for creating tabs in a formspec.
typedef TabInfo = {
	var name: String;
	var display: String;
}

class TabHeader extends FormspecElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done
	var currentTab: Int;
	var transparent = false;
	var drawBorder = false;
	// Tabs are a fixed size because I don't even want to think about making
	// tabs dynamic. That sounds horrifying.
	var tabs: String = "";

	public function new(x: Float, y: Float, width: Float, height: Float, drawBorder: Bool, defaultTab: Int, tabsArray: Array<TabInfo>) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.drawBorder = drawBorder;
		this.currentTab = defaultTab;

		// Convert the tabs array into a string.
		var length = tabsArray.length;
		if (length == 0) {
			throw 'Blank tabs array given for formspec header!';
		}

		for (index => tab in tabsArray) {
			this.tabs += tab.display;
			// This may be a mess but I want it to be a nice mess.
			if (index + 1 < length) {
				this.tabs += ",";
			}
		}
	}

	public function toFormspec(name: String): String {
		return 'tabheader[${this.x},${this.y};${this.width},${this.height};${name};${this.tabs};${this.currentTab};${this.transparent};${this.drawBorder}]';
	}

	public function setStyle(style: TabHeaderStyle): TabHeader {
		this.style = style;
		return this;
	}

	public function getStyle(): TabHeaderStyle {
		return cast this.style;
	}

	public function setPos(x: Float, y: Float): TabHeader {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): TabHeader {
		this.width = width;
		this.height = height;
		return this;
	}

	public function setCurrentTab(tab: Int): TabHeader {
		this.currentTab = tab;
		return this;
	}
}

class TabHeaderStyle extends FormspecStyle {
	var sound: String;
	var textColor: String;

	public function new() {}

	public function toFormspec(name: String, windowScale: Float): String {
		append('style[${name}');

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

	public function setSound(sound: String): TabHeaderStyle {
		this.sound = sound;
		return this;
	}

	public function setTextColor(textColor: String): TabHeaderStyle {
		this.textColor = textColor;
		return this;
	}
}
