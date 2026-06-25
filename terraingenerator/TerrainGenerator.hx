package terraingenerator;

import lua.Lua;
import src.engine.Core;

/**
 * This is the terrain generator.
 * It runs multi threaded in the game engine.
 * I think that's pretty neat.
 */
class TerrainGenerator {
	static function main() {
		Lua.print("[Terrain generator loaded]");
		Core.log(LogLevelNone, "test");
	}
}
