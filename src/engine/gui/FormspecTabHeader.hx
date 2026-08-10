package src.engine.gui;

import haxe.Rest;
import src.engine.gui.Formspec.FormspecElement;

// This is a simple helper for creating tabs in a formspec.
typedef TabInfo = {
	var name: String;
	var display: String;
}

class FormspecTabHeader extends FormspecElement {
	var x: Float; // ? Done.
	var y: Float; // ? Done.
	var width: Float; // ? Done.
	var height: Float; // ? Done
	// Setting the current tab is unavailable because I don't even want to
	// think about the spaghetti code needed to make that work properly.
	var currentTab = 1;
	var transparent = false;
	var drawBorder = false;
	// Tabs are a fixed size because I don't even want to think about making
	// tabs dynamic. That sounds horrifying.
	var tabs: String = "";

	public function new(x: Float, y: Float, width: Float, height: Float, drawBorder: Bool, firstTab: String, restOfTabs: Rest<String>) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.drawBorder = drawBorder;

		var length = restOfTabs.length;

		this.tabs = firstTab;
		if (length != 0) {
			this.tabs += ",";
		}

		for (index => tab in restOfTabs) {
			this.tabs += tab;
			// This may be a mess but I want it to be a nice mess.
			if (index + 1 < length) {
				this.tabs += ",";
			}
		}
	}

	public function toFormspec(name: String): String {
		return 'tabheader[${this.x},${this.y};${this.width},${this.height};${name};${this.tabs};${this.currentTab};${this.transparent};${this.drawBorder}]';
	}

	public function setPos(x: Float, y: Float): FormspecTabHeader {
		this.x = x;
		this.y = y;
		return this;
	}

	public function setSize(width: Float, height: Float): FormspecTabHeader {
		this.width = width;
		this.height = height;
		return this;
	}
}
