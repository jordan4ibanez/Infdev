package definition;

import lua.Table;

@:forward
abstract PointabilitySetting(Dynamic) from Dynamic to Dynamic {
	public static inline var True: Bool = true;
	public static inline var False: Bool = false;
	public static inline var Blocking: String = "blocking";
	public static inline var LiquidsPointable: String = "liquids_pointable";
	public static inline var Pointable: String = "pointable";
}

class Pointabilities {
	public var nodes: Table<String, PointabilitySetting>;
	public var objects: Table<String, PointabilitySetting>;
}
