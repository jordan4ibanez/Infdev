package engine.definition.basic;

import haxe.extern.EitherType;
import lua.Table;
import haxe.Rest;

// Design goal: functional oop and make it look like lisp

class NodeDrop {
	var rarity: Int = 1;
	var items: Table<Int, String> = Table.create();
	var tools: Table<Int, String>;
	@:native("inherit_color")
	var inheritColor: Bool;
	@:native("tool_groups")
	var toolGroups: Table<Int, EitherType<String, Table<Int, String>>>;

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

	public function addToolGroupRequirements(groupRequirements: Rest<EitherType<String, Array<String>>>): NodeDrop {
		if (toolGroups == null) {
			toolGroups = Table.create();
		}

		for (groupRequirement in groupRequirements) {
			if (Std.isOfType(groupRequirement, String)) {
				Table.insert(this.toolGroups, groupRequirement);
			} else if (Std.isOfType(groupRequirement, Array)) {
				var translatedToLuaTable = Table.create();
				for (component in cast(groupRequirement, Array<Dynamic>)) {
					Table.insert(translatedToLuaTable, component);
				}
				Table.insert(this.toolGroups, translatedToLuaTable);
			}
		}
		return this;
	}

	public function setDugNodeColorInheritance(): NodeDrop {
		this.inheritColor = true;
		return this;
	}
}

class NodeDropTable {
	@:native("max_items")
	private var maxItems: Int = 1;

	private var items: Table<Int, NodeDrop>;

	/**
	 * If one item is there, it will set it up to just drop that one item.
	 * Otherwise, use chaining to build it up.
	 * @param oneItem The one item to drop.
	 */
	public function new(?oneItem: String) {
		if (oneItem != null) {
			this.addDrop(new NodeDrop()
				.addItems(oneItem));
		}
	}

	public function setMaxItems(maxItems: Int): NodeDropTable {
		this.maxItems = maxItems;
		return this;
	}

	public function addDrop(drop: NodeDrop): NodeDropTable {
		if (this.items == null) {
			this.items = Table.create();
		}
		Table.insert(this.items, drop);
		return this;
	}
}

// class Blah {
// 	static function __init__() {
// 		var i = new NodeDropTable()
// 			.setMaxItems(10)
// 			.addDrop(new NodeDrop()
// 				.addItems("test", "flop")
// 					// .addToolRequirements("shovel", "pickaxe")
// 				.addToolGroupRequirements("magicwand", ["pickaxe", "lucky"])
// 				.setDugNodeColorInheritance());
// 		untyped __lua__("print(dump(i))");
// 	}
// }
