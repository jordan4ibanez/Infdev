package src.engine;

import lua.Table;

@:final
abstract class GameInfo {
	// This is for things specifically unavailable during runtime.
	public static final modName = Core.getCurrentModName();
	public static final path = Core.getModPath(modName);
	public static inline final schematicPath: String = "schematics/";

	// This is a custom hack job to implement somewhat random noise values per world.
	public static function getMapSeed(): Int {
		var output = 0;
		var mapSeedString = Core.getMapSeedString();
		for (i in 0...mapSeedString.length) {
			output += (untyped tonumber(mapSeedString.charAt(i))) * i;
		}
		// untyped print(output);
		return output;
	};

	// todo: request insecure environment.
	static var insecureContainer: Dynamic = Table.create();

	// This is AI assisted.
	public static function getLocalCount(?level: Int): Int {
		// Default to level 2 (the caller of this function).
		var level = (level ?? 1) + 1;
		var count = 0;

		while (true) {
			var name = insecureContainer.debug.getlocal(level, count + 1);
			if (name == null) {
				break;
			}
			count = count + 1;
		}
		return count;
	}
}
