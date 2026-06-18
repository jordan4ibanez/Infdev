package engine;

final class ItemStack {
	var name: String;
	var count: Int;
	var wear: Int;
	var metadata: String;

	public function new() {}
}

class Blah {
	static function __init__() {
		new ItemStack();
	}
}
