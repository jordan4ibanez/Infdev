package src.engine.gui;

import src.engine.definition.graphics.RGBA;
import src.engine.vector.Vec2;

// This file contains a bunch of classes to allow a single import.

class Formspec {
	final name: String;

	var data = "";

	final version = 10;
	var size: Vec2 = new Vec2(10, 10);
	var fixedSize: Bool = false;
	// todo: replace this with a background texture using 9 segment and use it for EVERYTHING.
	var backgroundColor: String = new RGBA(77, 77, 77, 248).toHex();
	var fullscreen: Bool = false;
	var foregroundColor: String = "";

	// Elements not in a container.
	var elements: Map<String, FormspecElement> = new Map();

	// todo: element containers.
	// todo: do not allow nested containers because that can become a nightmare.

	public function new(name: String) {
		this.name = name;
	}

	function append(newData: String): Void {
		this.data += newData;
	}

	function getName(): String {
		return this.name;
	}

	// This is the function that turns this thing into a string the game can process.
	public function serialize(): String {
		append('formspec_version[${this.version}]');
		append('size[${this.size.x},${this.size.y},${this.fixedSize}]');
		append('bgcolor[${this.backgroundColor};${this.fullscreen};${this.foregroundColor}]');

		// todo: run through the formspec elements and fire them out.

		for (name => element in elements) {
			// This auto targets the styling to the element.
			if (element.style != null) {
				append(element.style.toFormspec(name));
			}
			trace(name);
			append(element.toFormspec());
		}

		untyped print(this.data);

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

	public function setBackgroundColor(color: String): Formspec {
		this.backgroundColor = color;
		return this;
	}

	public function setFullscreen(fullscreen: Bool): Formspec {
		this.fullscreen = fullscreen;
		return this;
	}

	public function setForegroundColor(color: String): Formspec {
		this.foregroundColor = color;
		return this;
	}

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
	public abstract function toFormspec(): String;
}

// todo: @:noCompletion
abstract class FormspecStyle {
	// todo: there's a lot of stuff in this one. So this will have to be thought about. For now it's just a simple one.
	var data: String = "";

	// todo: @:noCompletion
	public abstract function toFormspec(name: String): String;

	inline function append(newData: String, ?doNotAddSeparator: Bool = false): Void {
		this.data += newData;
		if (!doNotAddSeparator) {
			this.data += ";";
		}
	}
}
