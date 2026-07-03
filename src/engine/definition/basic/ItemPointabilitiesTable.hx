package src.engine.definition.basic;

import lua.Table;

@:forward
enum abstract ItemPointable(Dynamic) from Dynamic to Dynamic {
	var ItemPointableTrue: Bool = true;
	var ItemPointableFalse: Bool = false;
	var ItemPointableBlocking: String = "blocking";
	var ItemPointableLiquidsPointable: String = "liquids_pointable";
	inline var ItemPointablePointable: String = "pointable";
}

@:forward
abstract ItemPointableMap(Table<String, ItemPointable>) from Table<String, ItemPointable> to Table<String, ItemPointable> {
	public inline function new() {
		this = Table.create();
	}

	@:arrayAccess
	public inline function set(key: String, value: ItemPointable): ItemPointableMap {
		this[cast key] = value;
		return cast this;
	}

	@:arrayAccess
	public inline function get(key: String): Null<ItemPointable> {
		return this[cast key];
	}
}

class ItemPointabilitiesTable {
	public var nodes: ItemPointableMap;
	public var objects: ItemPointableMap;

	public function new(?nodes: ItemPointableMap, ?objects: ItemPointableMap) {
		this.nodes = nodes;
		this.objects = objects;
	}

	public function setNodes(nodes: ItemPointableMap): ItemPointabilitiesTable {
		this.nodes = nodes;
		return this;
	}

	public function setObjects(objects: ItemPointableMap): ItemPointabilitiesTable {
		this.objects = objects;
		return this;
	}
}
