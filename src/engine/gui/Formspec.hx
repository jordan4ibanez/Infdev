package src.engine.gui;

import src.engine.vector.Vec2;

class Formspec {
	var data = "";

	final version = 10;
	var size: Vec2 = new Vec2(10, 10);
	var fixedSize: Bool = false;

	public function new() {}

	function append(newData: String): Void {
		this.data += newData;
	}

	// This is the function that turns this thing into a string the game can process.
	public function serialize(): String {
		append('formspec_version[${this.version}]');
		append('size[${this.size.x},${this.size.y},${this.fixedSize}]');

		untyped print(this.data);
		return this.data;
	}

}
