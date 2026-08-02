package src.engine;

@:final
abstract class GameInfo {
	// This is for things specifically unavailable during runtime.
	public static final modName = Core.getCurrentModName();
	public static final path = Core.getModPath(modName);
	public static inline final schematicPath: String = "schematics/";
}
