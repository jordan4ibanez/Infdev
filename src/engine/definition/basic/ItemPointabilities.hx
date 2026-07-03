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


// todo: this needs a custom type for creating a lua table.

// I keep misreading this: It literally means Point Table.
typedef PointTable = Table<String, ItemPointable>;

class ItemPointabilities {
	public var nodes: PointTable;
	public var objects: PointTable;

	public function new(nodes: Null<PointTable>, objects: Null<PointTable>) {
		this.nodes = nodes;
		this.objects = objects;
	}
}
