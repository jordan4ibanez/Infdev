package src.engine;

import lua.Lua;

@:final
abstract class GameInfo {
	// This is for things specifically unavailable during runtime.
	public static final modName = Core.getCurrentModName();
	public static final path = Core.getModPath(modName);
	public static inline final schematicPath: String = "schematics/";
	public static final gravity: Float = Lua.tonumber(cast Core.settings.get("movement_gravity")) ?? 9.81;

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

	// Below this is a custom monstrosity to get the local count at any point in this haxe code.
	static var DEBUG_MODE = true;

	static var insecureContainer: Dynamic = untyped compilerDebugUnsafeEnvironment;

	public static function getInsecureEnvironment(): Dynamic {
		if (!DEBUG_MODE) {
			throw "INSECURE ENVIRONMENT REQUESTED WITH DEBUG MODE SET TO OFF!";
		}
		if (insecureContainer == null) {
			throw "INSECURE ENVIRONMENT REQUESTED WITH COMPILER DEBUG MODE SET TO OFF OR NOT IN TRUSTED MODS!";
		}
		return insecureContainer;
	}

	// This is AI assisted.
	public static function getLocalCount(?level: Int, ?bypass: Dynamic): Int {
		if (!DEBUG_MODE && (bypass == null && insecureContainer == null)) {
			throw "Enable debug mode in this and the compiler. If this is already set, add infdev to trusted mods.";
		}
		// Default to level 2 (the caller of this function).
		var level = (level ?? 1) + 1;
		var count = 0;

		while (true) {
			var name = (insecureContainer == null) ? untyped bypass.debug["getlocal"](level, count + 1) : untyped insecureContainer.debug["getlocal"](level, count
				+ 1);
			if (name == null) {
				break;
			}
			count = count + 1;
		}
		return count;
	}
}
