package src.engine.entity.definition;

@:forward
abstract EntityPointability(Dynamic) from Dynamic to Dynamic {
	public static inline var True: Bool = true;
	public static inline var False: Bool = false;
	public static inline var Blocking: String = "blocking";
}
