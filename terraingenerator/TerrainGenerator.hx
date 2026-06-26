package terraingenerator;

import src.engine.Core;

/**
 * This is the terrain generator.
 * It runs multi threaded in the game engine.
 * I think that's pretty neat.
 */
class TerrainGenerator {
	final chunk_size = Core.get_mapgen_chunksize();
	final c_dirt = Core.get_content_id("infdev:dirt");
	final c_stone = Core.get_content_id("infdev:stone");
	final c_air = Core.get_content_id("air");
	final c_grass = Core.get_content_id("infdev:grass");
	final c_water_source = Core.get_content_id("infdev:water_source");
	final c_sand = Core.get_content_id("infdev:sand");
	final c_bedrock = Core.get_content_id("infdev:bedrock");
	final c_sandstone = Core.get_content_id("infdev:sandstone");
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
