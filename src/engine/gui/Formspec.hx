package src.engine.gui;

import src.engine.entity.objectref.ObjectRefPlayer;
import src.engine.vector.Vec2;

// This file contains a bunch of classes to allow a single import.

class Formspec {
	static inline final DEBUG_MODE = true;

	final name: String;

	var data = "";

	final version = 10;
	var size: Vec2 = new Vec2(10, 10);
	var fixedSize: Bool = false;

	// var backgroundColor: String = new RGBA(77, 77, 77, 248).toHex();
	// var fullscreen: Bool = false;
	// var foregroundColor: String = "";
	static inline final baseWindowSizeX = 1920;
	static inline final baseWindowSizeY = 1080;

	// Elements not in a container.
	var elements: Map<String, FormspecElement> = new Map();

	// todo: element containers.
	// todo: do not allow nested containers because that can become a nightmare.

	public function new(name: String) {
		this.name = name;
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

	function getTrueWindowScale(player: ObjectRefPlayer): Float {
		var scale: Float = 0;

		var windowInfo = player.getLuaEntity().getWindowInformation();

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
	public function serialize(player: ObjectRefPlayer): String {
		append('formspec_version[${this.version}]');
		append('size[${this.size.x},${this.size.y},${this.fixedSize}]');
		append('bgcolor[#00000000;false;]');
		append('background9[0,0;0,0;infdev_menu_background.png;true;40]');

		var windowScale = getTrueWindowScale(player);

		for (name => element in elements) {
			// This auto targets the styling to the element.
			if (element.style != null) {
				append(element.style.toFormspec(name, windowScale));
			}
			// trace(name);
			append(element.toFormspec(name));
		}

		// untyped print(this.data);

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

	// public function setBackgroundColor(color: String): Formspec {
	// 	this.backgroundColor = color;
	// 	return this;
	// }
	// public function setFullscreen(fullscreen: Bool): Formspec {
	// 	this.fullscreen = fullscreen;
	// 	return this;
	// }
	// public function setForegroundColor(color: String): Formspec {
	// 	this.foregroundColor = color;
	// 	return this;
	// }

	public function addElement(elementName: String, formspecElement: FormspecElement): Formspec {
		// This errors out to prevent catastrophic bugs.
		if (this.elements.exists(elementName)) {
			throw 'Tried to add element [${elementName}] into formspec [${this.name}] when it already exists.';
		}
		this.elements.set(elementName, formspecElement);
		return this;
	}

	public function getElement<T: FormspecElement>(elementName: String): Null<T> {
		return cast this.elements.get(elementName);
	}
}

// todo: @:noCompletion
abstract class FormspecElement {
	// todo: @:noCompletion
	public var style: FormspecStyle;

	// todo: @:noCompletion
	public abstract function toFormspec(name: String): String;
}

// todo: @:noCompletion
abstract class FormspecStyle {
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
