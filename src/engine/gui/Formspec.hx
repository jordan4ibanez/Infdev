package src.engine.gui;

import lua.Table;
import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.vector.Vec2;

class Formspec {
	static inline final DEBUG_MODE = false;

	// Static components that make formspecs reactive instead of static.
	static var masterFormspecContainer: Map<String, Map<String, Formspec>> = new Map();

	@:noCompletion
	public static function addPlayerToMasterFormspecContainer(player: ObjectRefPlayer): Void {
		masterFormspecContainer.set(player.getPlayerName(), new Map());
	}

	@:noCompletion
	public static function removePlayerFromMasterFormspecContainer(player: ObjectRefPlayer): Void {
		masterFormspecContainer.remove(player.getPlayerName());
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

		if (thisFormspec.actionOnAnyUpdate != null) {
			thisFormspec.actionOnAnyUpdate(fields);
		}

		if (fields.quit == "true") {
			if (thisFormspec.actionOnClose != null) {
				thisFormspec.actionOnClose();
			}
		}

		// untyped print(formName);
		// untyped print(dump(fields));
		// untyped print(thisFormspec);
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

	final version = 10;
	var size: Vec2 = new Vec2(10, 10);
	var fixedSize: Bool = false;

	var actionOnClose: Null<() -> Void>;
	var actionOnAnyUpdate: Null<(fields: Table<String, String>) -> Void>;

	// var backgroundColor: String = new RGBA(77, 77, 77, 248).toHex();
	// var fullscreen: Bool = false;
	// var foregroundColor: String = "";
	static inline final baseWindowSizeX = 1920;
	static inline final baseWindowSizeY = 1080;

	// Elements not in a container.
	// These are drawn on every page of the formspec.
	// This is also used for single page formspecs without any navigation.
	var rootElements: Map<String, FormspecElement> = new Map();
	var pages: Map<String, Map<String, FormspecElement>> = new Map();
	var currentPage: Null<String> = null;

	// todo: element containers.
	// todo: do not allow nested containers because that can become a nightmare.

	public function new(name: String, ?defaultPage: String) {
		this.name = name;
		if (defaultPage != null) {
			this.currentPage = defaultPage;
		}
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

	function getName(): String {
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
				trace('SERIALIZE PAGE ${currentPage}');
			}
		}

		// Reset the data output to prevent a disaster.
		var output = this.data;
		this.data = "";

		return output;
	}

	public function setSize(x: Float, y: Float): Formspec {
		this.size.setFloats(x, y);
		return this;
	}

	public function isFixedSize(fixedSize: Bool): Formspec {
		this.fixedSize = fixedSize;
		return this;
	}

	public function addElement(pageName: String, elementName: String, formspecElement: FormspecElement): Formspec {
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
		thisPage.set(elementName, formspecElement);
		return this;
	}

	public function getElement<T: FormspecElement>(pageName: String, elementName: String): Null<T> {
		var thisPage = this.pages.get(pageName);
		if (thisPage == null) {
			return null;
		}
		return cast thisPage.get(elementName);
	}

	public function addRootElement(elementName: String, formspecElement: FormspecElement): Formspec {
		// This errors out to prevent catastrophic bugs.
		if (this.rootElements.exists(elementName)) {
			throw 'Tried to add element [${elementName}] in formspec [${this.name}] when it already exists.';
		}
		this.rootElements.set(elementName, formspecElement);
		return this;
	}

	public function getRootElement<T: FormspecElement>(elementName: String): Null<T> {
		return cast this.rootElements.get(elementName);
	}

	// Global interactive functions.

	/**
	 * When the formspec closes, this action will run.
	 * @param action 
	 */
	public function doActionOnClose(action: () -> {}): Formspec {
		this.actionOnClose = action;
		return this;
	}

	/**
	 * Any time this formspec's element trigger an receive fields, this action will run and receive all the fields from the update.
	 * It is to be used as a global interactive action for the player's formspec.
	 * @param action 
	 */
	public function doActionOnAnyUpdate(action: (fields: Table<String, String>) -> Void): Formspec {
		this.actionOnAnyUpdate = action;
		return this;
	}
}

// todo: @:noCompletion
abstract class FormspecElement {
	// todo: @:noCompletion
	public var style: FormspecStyle;

	// There were a few ways to write this, but this is probably the least bad.
	// It's very flexible!
	public var action: Null<(fields: Table<String, String>) -> Void>;

	public function setAction(action: (fields: Table<String, String>) -> Void): FormspecElement {
		this.action = action;
		return this;
	}

	// todo: @:noCompletion
	public abstract function toFormspec(name: String): String;
}

// todo: @:noCompletion
abstract class FormspecStyle {
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
