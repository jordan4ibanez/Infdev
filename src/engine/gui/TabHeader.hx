package src.engine.gui;

import lua.Table;
import src.engine.gui.Button.ButtonStyle;
import src.engine.gui.Gui.FormspecElement;
import src.engine.vector.Vec3;

// This is a simple helper for creating tabs in a formspec.
typedef TabInfo = {
	var name: String;
	var display: String;
}

// This essentially works as an API to implement a row of buttons.
// It is an external controller for buttons in the GUI.
class TabHeader extends FormspecElement {
	// This is 0 indexed.
	var currentTab: Int = 0;
	// This is for this controller
	var tabs: Array<Button> = [];
	// ! Never delete this, it's used for action assignment.
	var tempName: String;
	var selectedStyle: TabHeaderStyle;
	var rootPos: Vec3;
	var rootSize: Vec3;

	public function new(page: Null<String>, isRootElement: Bool, baseElementName: String, basePosX: Float, basePosY: Float, tabWidth: Float, tabHeight: Float, spaceBetweenTabs: Float, drawBorder: Bool, defaultTab: Int, tabsArray: Array<TabInfo>) {
		// Convert the tabs array into a string.
		var length = tabsArray.length;
		if (length == 0) {
			throw 'Blank tabs array given for formspec header!';
		}
		this.rootPos = new Vec3(basePosX, basePosY);
		this.rootSize = new Vec3(tabWidth, tabHeight);
		this.tempName = baseElementName;

		// The origin formspec is injected into the element immediately after it is put into it.
		// So it needs to wait 1 server tick.
		Core.after(0, () -> {
			for (index => tab in tabsArray) {
				var thisButton = new Button(basePosX + (index * tabWidth) +
					(index * spaceBetweenTabs), basePosY, tabWidth, tabHeight, tabsArray[index].display);
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

	public function setStyles(unselectedStyle: TabHeaderStyle, selectedStyle: TabHeaderStyle): TabHeader {
		this.style = unselectedStyle;
		this.selectedStyle = selectedStyle;
		Core.after(0, () -> {
			for (index => tab in this.tabs) {
				if (index == this.currentTab) {
					tab.setStyle(this.selectedStyle);
				} else {
					tab.setStyle(cast this.style);
				}
			}
			// ? This triggers the tab logic to create the initial bigger tab selection effect.
			this.currentTab = 1;
			this.setCurrentTab(0);
		});
		return this;
	}

	public function getStyle(): TabHeaderStyle {
		return cast this.style;
	}

	public function getSelectedStyle(): TabHeaderStyle {
		return cast this.selectedStyle;
	}

	public function setCurrentTab(tab: Int): TabHeader {
		var oldTabIndex = this.currentTab;
		this.currentTab = tab;
		var thisSelectedStyle = this.selectedStyle == null ? this.style : this.selectedStyle;

		var oldTab = this.tabs[oldTabIndex];
		var newTab = this.tabs[this.currentTab];

		// No styles were supplied, which is perfectly valid.
		if (thisSelectedStyle != null) {
			oldTab.setStyle(cast this.style);
			newTab.setStyle(cast thisSelectedStyle);
		}

		// Do the fancy effect where the tab looks closer.
		var newPos = newTab.getPos();
		newTab.setPos(newPos.x, rootPos.y + 0.025);
		newTab.setSize(rootSize.x, rootSize.y + 0.05);

		var oldPos = oldTab.getPos();
		oldTab.setPos(oldPos.x, rootPos.y);
		oldTab.setSize(rootSize.x, rootSize.y);

		return this;
	}

	public function getCurrentTab(): Int {
		return this.currentTab;
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
