package terraingenerator;

import src.engine.Core;

/**
 * This is the terrain generator.
 * It runs multi threaded in the game engine.
 * I think that's pretty neat.
 */
class TerrainGenerator {
	final chunk_size = Core.getMapgenChunkSize();
	final c_dirt = Core.getContentID("infdev:dirt");
	final c_stone = Core.getContentID("infdev:stone");
	final c_air = Core.getContentID("air");
	final c_grass = Core.getContentID("infdev:grass");
	final c_water_source = Core.getContentID("infdev:water_source");
	final c_sand = Core.getContentID("infdev:sand");
	final c_bedrock = Core.getContentID("infdev:bedrock");
	final c_sandstone = Core.getContentID("infdev:sandstone");

	public function new() {
		Core.log(LogLevelNone, "test");
	}

	static function main() {
		new TerrainGenerator();
	}

	function clamp(input: Float, low: Float, high: Float): Float {
		if (low > high) {
			low = high;
			high = low;
		}
		return Math.max(low, Math.min(high, input));
	}
}
