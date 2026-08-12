package src.engine.gui;

import lua.Table;
import src.engine.gui.Button.ButtonStyle;
import src.engine.gui.Gui.FormspecElement;

// This is a simple helper for creating tabs in a formspec.
typedef TabInfo = {
	var name: String;
	var display: String;
}

// This essentially works as an API to implement a row of buttons.
// It is an external controller for buttons in the GUI.
class TabHeader extends FormspecElement {
	var currentTab: Int;
	// This is for this controller
	var tabs: Array<Button> = [];
	// ! Never delete this, it's used for action assignment.
	var tempName: String;

	public function new(page: Null<String>, isRootElement: Bool, baseElementName: String, basePosX: Float, basePosY: Float, tabWidth: Float, tabHeight: Float, spaceBetweenTabs: Float, drawBorder: Bool, defaultTab: Int, tabsArray: Array<TabInfo>) {
		// Convert the tabs array into a string.
		var length = tabsArray.length;
		if (length == 0) {
			throw 'Blank tabs array given for formspec header!';
		}

		this.tempName = baseElementName;

		// The origin formspec is injected into the element immediately after it is put into it.
		// So it needs to wait 1 server tick.
		Core.after(0, () -> {
			for (index => tab in tabsArray) {
				var thisButton = new Button(basePosX + (index * tabWidth), basePosY, tabWidth, tabHeight, "test");
				tabs.push(thisButton);
				if (isRootElement) {
					this.origin.addRootElement('${baseElementName}_${index}', thisButton);
				} else {
					if (page == null || page == "") {
						throw 'Forgot to add in page for a non-root tab header';
					}
					this.origin.addElement(page, '${baseElementName}_${index}', thisButton);
				}
			}
		});
	}

	public function toFormspec(name: String): String {
		return "";
	}

	public function setStyle(style: TabHeaderStyle): TabHeader {
		this.style = style;
		Core.after(0, () -> {
			for (tab in this.tabs) {
				tab.setStyle(style);
			}
		});
		return this;
	}

	public function getStyle(): TabHeaderStyle {
		return cast this.style;
	}

	public function setCurrentTab(tab: Int): TabHeader {
		this.currentTab = tab;
		return this;
	}

	override function setAction(action: (thisFormspec: Gui, thisElement: FormspecElement, fields: Table<String, String>) -> Void): FormspecElement {
		super.setAction(action);
		// Delay it so it can be tagged as actionable in the GUI.
		Core.after(0, () -> {
			for (index => tab in this.tabs) {
				tab.setAction(action);
				if (this.origin == null) {
					throw 'Null origin in tab header when applying button actions.';
				}
				this.origin.tagActionable('${this.tempName}_${index}');
			}
		});
		return this;
	}
}

typedef TabHeaderStyle = ButtonStyle;
