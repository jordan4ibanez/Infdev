package engine.definition.basic;

import lua.Table;

@:forward
abstract PointabilitySetting(Dynamic) from Dynamic to Dynamic {
	public static inline var True: Bool = true;
	public static inline var False: Bool = false;
	public static inline var Blocking: String = "blocking";
	public static inline var LiquidsPointable: String = "liquids_pointable";
	public static inline var Pointable: String = "pointable";
}

typedef PointTable = Table<String, PointabilitySetting>;

class Pointabilities {
	public var nodes: PointTable;
	public var objects: PointTable;

	public function new(nodes: Null<PointTable>, objects: Null<PointTable>) {
		this.nodes = nodes;
		this.objects = objects;
	}
}
