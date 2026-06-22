package engine.definition.basic;

import haxe.Rest;

// Design goal: functional oop and make it look like lisp

class NodeDrop {
	var rarity: Int = 1;

	var items: Array<String> = [];

	public function new() {}

	public function setRarity(rarity: Int): NodeDrop {
		this.rarity = rarity;
		return this;
	}

	public function addItem(item: String): NodeDrop {
		this.items.push(item);
		return this;
	}

	public function addItems(items: Rest<String>): NodeDrop {
		for (item in items) {
			this.items.push(item);
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
