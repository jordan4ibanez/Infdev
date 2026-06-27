package terraingenerator;

import src.engine.vector.Vec3;
import src.engine.NodeTable;
import lua.Lua;
import lua.Table;
import src.engine.VoxelManip;
import src.engine.vector.EngineVector3;
import src.engine.Core;
import src.engine.NoiseParams;

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

	// local cave_blend_parameters                    = {
	// 	offset = 0, //
	// 	scale = 0.5, //
	// 	spread = { x = 100, y = 100, z = 100 }, //
	// 	seed = tonumber(core.get_mapgen_setting("seed")) + 111 or math.random(0, 999999999), //
	// 	octaves = 2,
	// 	persist = 1.0,
	// 	lacunarity = 2.0,
	// }
	var caveBlendParameters = new NoiseParams()

	// local big_cave_noise_parameters                = {
	// 	offset = 0,
	// 	scale = 1,
	// 	spread = { x = 25, y = 25, z = 25 },
	// 	seed = tonumber(core.get_mapgen_setting("seed")) or math.random(0, 999999999),
	// 	octaves = 2,
	// 	persist = 0.2,
	// 	lacunarity = 5.0,
	// }
	// local small_cave_noise_parameters              = {
	// 	offset = 0,
	// 	scale = 1,
	// 	spread = { x = 7, y = 7, z = 7 },
	// 	seed = tonumber(core.get_mapgen_setting("seed")) or math.random(0, 999999999),
	// 	octaves = 1,
	// 	persist = 0.3,
	// 	lacunarity = 3,
	// }
	// local overworld_terrain_blend_parameters       = {
	// 	offset = 0,
	// 	scale = 1,
	// 	spread = { x = 500, y = 500, z = 500 },
	// 	seed = tonumber(core.get_mapgen_setting("seed")) + 111 or math.random(0, 999999999),
	// 	octaves = 2,
	// 	persist = 1.0,
	// 	lacunarity = 2.0,
	// }
	// local overworld_terrain_noise_parameters_big   = {
	// 	offset = 0,
	// 	scale = 0.5,
	// 	spread = { x = 500, y = 400, z = 500 },
	// 	seed = tonumber(core.get_mapgen_setting("seed")) or math.random(0, 999999999),
	// 	octaves = 4,
	// 	persist = 0.63,
	// 	lacunarity = 2.0,
	// }
	// local overworld_terrain_noise_parameters_small = {
	// 	offset = 0,
	// 	scale = 0.5,
	// 	spread = { x = 50, y = 60, z = 50 },
	// 	seed = tonumber(core.get_mapgen_setting("seed")) or math.random(0, 999999999),
	// 	octaves = 2,
	// 	persist = 0.6,
	// 	lacunarity = 4.0,
	// }

	function clamp(input: Float, low: Float, high: Float): Float {
		if (low > high) {
			low = high;
			high = low;
		}
		return Math.max(low, Math.min(high, input));
	}

	function generateThread(voxelManip: VoxelManip, minPos: EngineVector3, maxPos: EngineVector3, blockSeed: Int): Void {
		trace("Good day, I am a map generator thread being called.");

		var data = voxelManip.getData();
	}

	// ? Everything below this is infrastructure to get the singleton map generator to load up.
	static function classGenerateThreadWrapper(voxelManip: VoxelManip, minPos: EngineVector3, maxPos: EngineVector3, blockSeed: Int): Void {
		instance.generateThread(voxelManip, minPos, maxPos, blockSeed);
	}

	public function new() {
		Core.log(LogLevelNone, "Spawned generator thread.");
	}

	static function main() {
		instance = new TerrainGenerator();
		Core.registerOnGeneratedMapgenThread(classGenerateThreadWrapper);
	}
}
