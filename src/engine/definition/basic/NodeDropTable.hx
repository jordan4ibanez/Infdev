package engine.definition.basic;

import lua.Table;
import haxe.Rest;

// Design goal: functional oop and make it look like lisp

class NodeDrop {
	var rarity: Int = 1;
	var items: Table<Int, String> = Table.create();
	var tools: Table<Int, String>;

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

	public function addToolRequirements(requirements: Rest<String>): NodeDrop {
		if (tools == null) {
			tools = Table.create();
		}
		for (requirement in requirements) {
			Table.insert(this.tools, requirement);
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
			.addItems("test", "flop")
			.addToolRequirements("shovel", "pickaxe");

		untyped __lua__("print(dump(i))");
	}
}
