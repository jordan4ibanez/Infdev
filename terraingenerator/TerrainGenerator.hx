package terraingenerator;

import src.engine.vector.EngineVector3;
import src.engine.Core;

/**
 * This is the terrain generator.
 * It runs multi threaded in the game engine.
 * I think that's pretty neat.
 */
class TerrainGenerator {
	static var instance: TerrainGenerator;

	final chunkSize = Core.getMapgenChunkSize();
	final dirtID = Core.getContentID("infdev:dirt");
	final stoneID = Core.getContentID("infdev:stone");
	final airID = Core.getContentID("air");
	final grassID = Core.getContentID("infdev:grass");
	final waterSourceID = Core.getContentID("infdev:water_source");
	final sandID = Core.getContentID("infdev:sand");
	final bedrockID = Core.getContentID("infdev:bedrock");
	final sandstoneID = Core.getContentID("infdev:sandstone");

	function clamp(input: Float, low: Float, high: Float): Float {
		if (low > high) {
			low = high;
			high = low;
		}
		return Math.max(low, Math.min(high, input));
	}

	static function main() {
		instance = new TerrainGenerator();
	}
}
