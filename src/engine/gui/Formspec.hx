package src.engine.gui;

class Formspec {
	var data = "";

	public function new() {}

	public function serialize(): String {
		return this.data;
	}
}
