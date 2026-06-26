package terraingenerator;

import src.engine.Core;

/**
 * This is the terrain generator.
 * It runs multi threaded in the game engine.
 * I think that's pretty neat.
 */
class TerrainGenerator {
	static function clamp(input: Float, low: Float, high: Float): Float {
		if (low > high) {
			low = high;
			high = low;
		}
		return Math.max(low, Math.min(high, input));
	}

	static function main() {
		Core.log(LogLevelNone, "test");
	}
}
