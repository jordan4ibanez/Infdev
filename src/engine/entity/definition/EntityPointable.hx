package src.engine.entity.definition;

@:forward
abstract EntityPointable(Dynamic) from Dynamic to Dynamic {
	public static inline var EntityPointabilityTrue: Bool = true;
	public static inline var EntityPointabilityFalse: Bool = false;
	public static inline var EntityPointabilityBlocking: String = "blocking";
}
