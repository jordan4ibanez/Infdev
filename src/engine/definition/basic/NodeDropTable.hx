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
				// .addToolRequirements("shovel", "pickaxe")
			.addToolGroupRequirements("magicwand", ["pickaxe", "lucky"])
			.setDugNodeColorInheritance();

		untyped __lua__("print(dump(i))");
	}
}
