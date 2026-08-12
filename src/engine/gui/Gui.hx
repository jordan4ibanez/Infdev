package src.engine.gui;

import lua.Table;
import src.engine.compilercode.LuaLoop;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.vector.Vec2;

enum abstract ElementLocation(String) to String {
	var ElementLocationRoot = "root";
	var ElementLocationPage = "page";
}

// This is a data container.
private class ElementInfo {
	public var location: ElementLocation;
	public var page: Null<String>;
	public var actionable: Bool;

	public function new() {}
}

class Gui {
	static inline final DEBUG_MODE = false;

	// Static components that make formspecs reactive instead of static.
	static var masterFormspecContainer: Map<String, Map<String, Gui>> = new Map();

	@:noCompletion
	public static function addPlayerToMasterFormspecContainer(player: ObjectRefPlayer): Void {
		masterFormspecContainer.set(player.getPlayerName(), new Map());
	}

	@:noCompletion
	public static function removePlayerFromMasterFormspecContainer(player: ObjectRefPlayer): Void {
		masterFormspecContainer.remove(player.getPlayerName());
	}

	@:noCompletion
	static function processElementAction(thisFormspec: Gui, elementKey: String, name: String, fields: Table<String, String>): Void {
		var elementInfo = thisFormspec.elementMap.get(elementKey);
		if (elementInfo == null) {
			throw 'Element ${elementKey} was null for ${name} in formspec ${thisFormspec.name}';
		}
		if (elementInfo.actionable) {
			if (elementInfo.location == ElementLocationRoot) {
				var gottenElement = thisFormspec.getRootElement(elementKey);
				if (gottenElement == null) {
					throw 'Root element ${elementKey} was null for ${name} in formspec ${thisFormspec.name}';
				}
				gottenElement.action(thisFormspec, gottenElement, fields);
			} else {
				var gottenElement = thisFormspec.getElement(elementInfo.page, elementKey);
				if (gottenElement == null) {
					throw 'Element ${elementKey} on page ${elementInfo.page} was null for ${name} in formspec ${thisFormspec.name}';
				}
				gottenElement.action(thisFormspec, gottenElement, fields);
			}
		}
	}

	// @:noCompletion
	static function doAllCurrentPageElementsSaveAttempt(thisFormspec: Gui, fields: Table<String, String>): Void {
		// So first run the root elements as they exist on every page.
		for (elementName => element in thisFormspec.rootElements) {
			if (element.isPersistent) {
				element.saveOnCloseAction(fields[cast elementName]);
			}
		}
		final currentPage: Null<String> = thisFormspec.currentPage;
		// This is a pageless GUI.
		if (currentPage == null) {
			return;
		}
		final currentPage: Null<Map<String, GuiElement>> = thisFormspec.pages.get(currentPage);
		if (currentPage == null) {
			throw 'Page ${thisFormspec.currentPage} in formspec ${thisFormspec.name} is null on close.';
		}
		for (elementName => element in currentPage) {
			if (element.isPersistent) {
				element.saveOnCloseAction(fields[cast elementName]);
			}
		}
	}

	@:noCompletion
	static function masterOnReceiveFields(player: ObjectRefPlayer, formName: String, fields: Table<String, String>): Void {
		var name = player.getPlayerName();

		var container = masterFormspecContainer.get(name);

		if (container == null) {
			Core.log(LogLevelError, 'Player ${name} has no formspec container!');
			return;
		}

		var key = keyThisWithPlayerName(formName, name);
		var thisFormspec = container.get(key);

		// This is done like this because quitting the formspec DOESN'T GIVE YOU ANY DATA.
		doAllCurrentPageElementsSaveAttempt(thisFormspec, fields);

		if (thisFormspec.actionOnAnyUpdate != null) {
			thisFormspec.actionOnAnyUpdate(thisFormspec, fields);
		}

		if (fields.quit == "true") {
			if (thisFormspec.actionOnClose != null) {
				thisFormspec.actionOnClose(thisFormspec);
			}
		} else {
			// Enter pressed on something.
			if (fields.key_enter == "true") {
				var elementKey = fields.key_enter_field;
				processElementAction(thisFormspec, elementKey, name, fields);
			} else {
				// A general action happened, so now it must search through all the field names for actions to produce.
				// There is no way to link components together in the luanti formspec api from what I can see.
				// ! So you probably shouldn't make fields or text areas do anything! :D

				LuaLoop.nativePairs(elementKey, value, fields, {
					processElementAction(thisFormspec, elementKey, name, fields);
				});
			}
		}
	}

	static function __init__(): Void {
		Core.registerOnPlayerReceiveFields(masterOnReceiveFields);
	}

	static function keyThisWithPlayerName(formspecName: String, playerName: String): String {
		return formspecName + "_" + playerName;
	}

	// End static components.
	final name: String;

	// This is used for interfunction memory.
	var data = "";

	var player: ObjectRefPlayer;

	final version = 11;
	var size: Vec2 = new Vec2(10, 10);
	var fixedSize: Bool = false;

	var actionOnClose: Null<(thisFormspec: Gui) -> Void>;
	var actionOnAnyUpdate: Null<(thisFormspec: Gui, fields: Table<String, String>) -> Void>;

	// var backgroundColor: String = new RGBA(77, 77, 77, 248).toHex();
	// var fullscreen: Bool = false;
	// var foregroundColor: String = "";
	static inline final baseWindowSizeX = 1920;
	static inline final baseWindowSizeY = 1080;

	// Elements not in a container.
	// These are drawn on every page of the formspec.
	// This is also used for single page formspecs without any navigation.
	var rootElements: Map<String, GuiElement> = new Map();

	// Elements in a container. These are called pages because they're supposed to be used as pages.
	var pages: Map<String, Map<String, GuiElement>> = new Map();
	var currentPage: Null<String> = null;

	// This is a wrapper to hold additional data about elements because the game is so bare bones with formspecs.
	var elementMap: Map<String, ElementInfo> = new Map();

	// todo: element containers.
	// todo: do not allow nested containers because that can become a nightmare.

	public function new(name: String, ?defaultPage: String) {
		this.name = name;
		if (defaultPage != null) {
			this.currentPage = defaultPage;
		}
	}

	public function goToPage(page: String): Void {
		final playerName = this.player.getPlayerName();
		if (!this.pages.exists(page)) {
			throw 'Tried to go to page ${page} in formspec ${this.name} for player ${playerName} which doesn\'t exist!';
		}
		this.currentPage = page;

		// ? This is a special clause for the player's inventory formspec.
		// ? This saves the page you were on.
		var formspecString = this.serialize();
		if (this.name == "") {
			this.player.setInventoryFormspec(formspecString);
		}
		Core.showFormspec(playerName, this.name, formspecString);
	}

	public function getPlayer(): Null<ObjectRefPlayer> {
		return this.player;
	}

	public function setPlayer(player: ObjectRefPlayer): Void {
		if (this.player != null) {
			throw 'Player set more than once in formspec ${this.name}';
		}
		this.player = player;

		var name = player.getPlayerName();
		var container = masterFormspecContainer.get(name);
		if (container == null) {
			Core.log(LogLevelError, 'Player ${name} has no formspec container!');
			return;
		}
		var key = keyThisWithPlayerName(this.name, name);
		if (container.exists(key)) {
			throw 'Duplicate formspec name in code! [${this.name}]';
		}
		container.set(key, this);
	}

	function append(newData: String): Void {
		this.data += newData;
		if (DEBUG_MODE) {
			this.data += "\n";
		}
	}

	public function getName(): String {
		return this.name;
	}

	function getTrueWindowScale(): Float {
		var scale: Float = 0;

		var windowInfo = this.player.getPlayerLuaEntity().getWindowInformation();

		if (windowInfo == null) {
			return 1;
		}

		var scaleX = windowInfo.size.x / baseWindowSizeX;
		var scaleY = windowInfo.size.y / baseWindowSizeY;

		// Pick the smaller scale.
		if (scaleX >= scaleY) {
			scale = scaleY;
		} else {
			scale = scaleX;
		}

		// Now apply gui scaling to it.
		var adjustmentFormula = (input: Float) -> {
			// Got a HUGE HUD I guess. Clamp it.
			if (input > 4) {
				input = 4;
			}
			return 1.25 - (0.25 * input);
		};

		var adjustment = adjustmentFormula(windowInfo.real_gui_scaling);

		scale *= adjustment;

		// untyped print('new scale: $scale');

		return scale;
	}

	// This is the function that turns this thing into a string the game can process.
	public function serialize(): String {
		append('formspec_version[${this.version}]');
		append('size[${this.size.x},${this.size.y},${this.fixedSize}]');
		append('bgcolor[#00000000;false;]');
		append('background9[0,0;0,0;infdev_menu_background.png;true;40]');
		append('style_type[list;spacing=0.075;size=0.75,0.75]');
		append('listcolors[#636363;#545454;black;#141414;#ffff00]');

		var windowScale = getTrueWindowScale();

		for (name => element in rootElements) {
			// This auto targets the styling to the element.
			if (element.style != null) {
				append(element.style.toFormspec(name, windowScale));
			}
			// trace(name);
			append(element.toFormspec(name));
		}

		if (DEBUG_MODE) {
			untyped print(this.data);
		}

		if (this.currentPage != null) {
			var thisPage = this.pages.get(this.currentPage);
			if (thisPage == null) {
				Core.log(LogLevelError, 'Formspec page ${this.currentPage} does not exist for formspec ${this.name}');
			} else {
				// Serialize the current page.
				for (name => element in thisPage) {
					// This auto targets the styling to the element.
					if (element.style != null) {
						append(element.style.toFormspec(name, windowScale));
					}
					// trace(name);
					append(element.toFormspec(name));
				}
				// trace('SERIALIZE PAGE ${currentPage}');
			}
		}

		// Reset the data output to prevent a disaster.
		var output = this.data;
		this.data = "";

		return output;
	}

	public function setSize(x: Float, y: Float): Gui {
		this.size.setFloats(x, y);
		return this;
	}

	public function isFixedSize(fixedSize: Bool): Gui {
		this.fixedSize = fixedSize;
		return this;
	}

	function tagElementInfo(elementName: String, formspecElement: GuiElement, root: Bool, ?page: String) {
		if (this.elementMap.exists(elementName)) {
			throw 'Duplicate element name ${elementName} in formspec ${this.name}';
		}
		var worker = new ElementInfo();
		if (root) {
			worker.location = ElementLocationRoot;
		} else {
			worker.location = ElementLocationPage;
			if (page == null) {
				throw 'Forgot to put in the page on registration.';
			}
			worker.page = page;
		}
		worker.actionable = (formspecElement.action != null);
		this.elementMap.set(elementName, worker);
	}

	public function addElement(pageName: String, elementName: String, formspecElement: GuiElement): Gui {
		// Create the page if it doesn't exist.
		var thisPage = this.pages.get(pageName);
		if (thisPage == null) {
			this.pages.set(pageName, new Map());
			thisPage = this.pages.get(pageName);
		}

		// This errors out to prevent catastrophic bugs.
		if (thisPage.exists(elementName)) {
			throw 'Tried to add element [${elementName}] into page [${pageName}] in formspec [${this.name}] when it already exists.';
		}
		formspecElement.origin = this;
		thisPage.set(elementName, formspecElement);
		this.tagElementInfo(elementName, formspecElement, false, pageName);
		return this;
	}

	public function getElement<T: GuiElement>(pageName: String, elementName: String): Null<T> {
		var thisPage = this.pages.get(pageName);
		if (thisPage == null) {
			return null;
		}
		return cast thisPage.get(elementName);
	}

	public function addRootElement(elementName: String, formspecElement: GuiElement): Gui {
		// This errors out to prevent catastrophic bugs.
		if (this.rootElements.exists(elementName)) {
			throw 'Tried to add element [${elementName}] in formspec [${this.name}] when it already exists.';
		}
		formspecElement.origin = this;
		this.rootElements.set(elementName, formspecElement);
		this.tagElementInfo(elementName, formspecElement, true);
		return this;
	}

	public function getRootElement<T: GuiElement>(elementName: String): Null<T> {
		return cast this.rootElements.get(elementName);
	}

	// Global interactive functions.

	/**
	 * When the formspec closes, this action will run.
	 * @param action 
	 */
	public function doActionOnClose(action: (thisFormspec: Gui) -> Void): Gui {
		this.actionOnClose = action;
		return this;
	}

	/**
	 * Any time this formspec's element trigger an receive fields, this action will run and receive all the fields from the update.
	 * It is to be used as a global interactive action for the player's formspec.
	 * @param action 
	 */
	public function doActionOnAnyUpdate(action: (thisFormspec: Gui, fields: Table<String, String>) -> Void): Gui {
		this.actionOnAnyUpdate = action;
		return this;
	}

	public function tagActionable(elementName: String): Void {
		var element = this.elementMap.get(elementName);
		if (element == null) {
			throw 'Element ${elementName} doesn\'t exist in GUI ${this.name}';
		}
		element.actionable = true;
	}
}

// todo: @:noCompletion
abstract class GuiElement {
	@:allow(src.engine.gui.Gui)
	var style: GuiStyle;
	@:allow(src.engine.gui.Gui)
	var isPersistent: Bool = false;

	// This is a reference to the base GUI. It is assigned by the GUI.
	public var origin: Gui;

	// There were a few ways to write this, but this is probably the least bad.
	// It's very flexible!
	@:allow(src.engine.gui.Gui)
	var action: Null<(thisFormspec: Gui, thisElement: GuiElement, fields: Table<String, String>) -> Void>;

	public function setAction(action: (thisFormspec: Gui, thisElement: GuiElement, fields: Table<String, String>) -> Void): GuiElement {
		this.action = action;
		return this;
	}

	public function setPersistent(isPersistent: Bool): Void {
		this.isPersistent = isPersistent;
	}

	// todo: @:noCompletion
	public abstract function toFormspec(name: String): String;

	public abstract function saveOnCloseAction(data: Null<String>): Void;
}

// todo: @:noCompletion
abstract class GuiStyle {
	public static inline final FONT_SIZE_DEFAULT: Float = 40;

	// todo: there's a lot of stuff in this one. So this will have to be thought about. For now it's just a simple one.
	var data: String = "";

	// todo: @:noCompletion
	public abstract function toFormspec(name: String, windowScale: Float): String;

	inline function append(newData: String, ?doNotAddSeparator: Bool = false): Void {
		// Remove the last ; off the string if do not add separator is there.
		if (doNotAddSeparator) {
			this.data = untyped __lua__("{0}:sub(1,-2)", this.data);
		}
		this.data += newData;
		if (!doNotAddSeparator) {
			this.data += ";";
		}
	}
}
