package src.engine;

@:final
abstract class GameInfo {
	// This is for things specifically unavailable during runtime.
	public static final modName = Core.getCurrentModName();
	public static final path = Core.getModPath(modName);
	public static inline final schematicPath: String = "schematics/";

	// This is a custom hack job to implement somewhat random noise values per world.
	public static final mapSeed: Int = (() -> {
		var output = 0;
		var mapSeedString = Core.getMapSeedString();
		for (i in 0...mapSeedString.length) {
			output += (untyped tonumber(mapSeedString.charAt(i))) * i;
		}
		untyped print(output);
		return output;
	})();
}
