package engine.definition.basic;

import lua.Table;
import haxe.Rest;

// Design goal: functional oop and make it look like lisp

class NodeDrop {
	var rarity: Int = 1;

	var items: Table<Int, String> = Table.create();

	public function new() {}

	public function setRarity(rarity: Int): NodeDrop {
		this.rarity = rarity;
		return this;
	}

	public function addItems(items: Rest<String>): NodeDrop {
		for (item in items) {
			Table.insert(this.items, item);
		}
		return this;
	}
}

class NodeDropTable {
	@:native("max_items")
	private var maxItems: Int = 1;

	public function new() {}

	public function setMaxItems(maxItems: Int): NodeDropTable {
		this.maxItems = maxItems;
		return this;
	}
}

class Blah {
	static function __init__() {
		var i = new NodeDrop()
			.addItem("test");

		untyped __lua__("print(dump(i))");
	}
}
