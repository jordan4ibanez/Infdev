package src.engine.entity.definition;

@:forward
abstract EntityPointable(Dynamic) from Dynamic to Dynamic {
	public static inline var EntityPointableTrue: Bool = true;
	public static inline var EntityPointableFalse: Bool = false;
	public static inline var EntityPointableBlocking: String = "blocking";
}
