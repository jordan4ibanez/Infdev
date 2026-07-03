package src.engine.definition.basic;

import lua.Table;

@:forward
abstract ItemPointable(Dynamic) from Dynamic to Dynamic {
	public static inline var ItemPointableTrue: Bool = true;
	public static inline var ItemPointableFalse: Bool = false;
	public static inline var ItemPointableBlocking: String = "blocking";
	public static inline var ItemPointableLiquidsPointable: String = "liquids_pointable";
	public static inline var ItemPointablePointable: String = "pointable";
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
}
