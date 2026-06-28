package terraingenerator;

import src.engine.vector.Vec2;
import src.engine.compilercode.LuaArray;
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

	final oceanLevel = 72;

	final stoneDisabled = false;

	final chunkSize = Core.getMapgenChunkSize();
	final dirtID = Core.getContentID("infdev:dirt");
	final stoneID = Core.getContentID("infdev:stone");
	final airID = Core.getContentID("air");
	final grassID = Core.getContentID("infdev:grass");
	final waterSourceID = Core.getContentID("infdev:water_source");
	final sandID = Core.getContentID("infdev:sand");
	final bedrockID = Core.getContentID("infdev:bedrock");
	final sandstoneID = Core.getContentID("infdev:sandstone");

	final caveBlendParameters = new NoiseParams()
		.setOffset(0) //
		.setScale(0.5) //
		.setSpread(new Vec3(100, 100, 100)) //
		.setSeed(Lua.tonumber(Core.getMapgenSetting("seed")) + 111)
		.setOctaves(2)
		.setPersistence(1.0)
		.setLacunarity(2.0);

	final bigCaveNoiseParameters = new NoiseParams()
		.setOffset(0)
		.setScale(1)
		.setSpread(new Vec3(25, 25, 25))
		.setSeed(Lua.tonumber(Core.getMapgenSetting("seed")))
		.setOctaves(2)
		.setPersistence(0.2)
		.setLacunarity(5.0);

	final smallCaveNoiseParameters = new NoiseParams()
		.setOffset(0)
		.setScale(1)
		.setSpread(new Vec3(7, 7, 7))
		.setSeed(Lua.tonumber(Core.getMapgenSetting("seed")))
		.setOctaves(1)
		.setPersistence(0.3)
		.setLacunarity(3);

	final overWorldTerrainBlendParameters = new NoiseParams()
		.setOffset(0)
		.setScale(1)
		.setSpread(new Vec3(500, 500, 500))
		.setSeed(Lua.tonumber(Core.getMapgenSetting("seed")) + 111)
		.setOctaves(2)
		.setPersistence(1)
		.setLacunarity(2);

	final overWorldTerrainNoiseParametersBig = new NoiseParams()
		.setOffset(0)
		.setScale(0.5)
		.setSpread(new Vec3(500, 400, 500))
		.setSeed(Lua.tonumber(Core.getMapgenSetting("seed")))
		.setOctaves(4)
		.setPersistence(0.63)
		.setLacunarity(2);

	final overWorldTerrainNoiseParametersSmall = new NoiseParams()
		.setOffset(0)
		.setScale(0.5)
		.setSpread(new Vec3(50, 60, 50))
		.setSeed(Lua.tonumber(Core.getMapgenSetting("seed")))
		.setOctaves(2)
		.setPersistence(0.6)
		.setLacunarity(4.0);

	function clamp(input: Float, low: Float, high: Float): Float {
		if (low > high) {
			low = high;
			high = low;
		}
		return Math.max(low, Math.min(high, input));
	}

	function generateThread(voxelManip: VoxelManip, minPos: EngineVector3, maxPos: EngineVector3, blockSeed: Int): Void {
		final constantArea3D = new Vec3(
			(maxPos.x - minPos.x) + 1,
			(maxPos.y - minPos.y) + 1,
			(maxPos.z - minPos.z) + 1
		);

		// local cave_blend_noise                         = {}
		// local __cave_blend_noise_map_3d                = core.get_value_noise_map(cave_blend_parameters,	__constant_area_3d)
		//
		// __cave_blend_noise_map_3d:get_3d_map_flat(minp, cave_blend_noise)

		final caveBlendNoise: LuaArray<Float> = Core.getValueNoiseMap(caveBlendParameters, constantArea3D).get3DMapFlat(minPos);

		// local big_cave_noise          = {}
		// local __big_cave_noise_map_3d = core.get_value_noise_map(big_cave_noise_parameters, __constant_area_3d)
		// __big_cave_noise_map_3d:get_3d_map_flat(minp, big_cave_noise)

		final bigCaveNoise: LuaArray<Float> = Core.getValueNoiseMap(bigCaveNoiseParameters, constantArea3D).get3DMapFlat(minPos);

		// local small_cave_noise          = {}
		// local __small_cave_noise_map_3d = core.get_value_noise_map(small_cave_noise_parameters, __constant_area_3d)
		// __small_cave_noise_map_3d:get_3d_map_flat(minp, small_cave_noise)

		final smallCaveNoise: LuaArray<Float> = Core.getValueNoiseMap(smallCaveNoiseParameters, constantArea3D).get3DMapFlat(minPos);

		// local __constant_area_2d                     = {
		// 	x = (maxp.x - minp.x) + 1,
		// 	y = (maxp.z - minp.z) + 1
		// }

		final constantArea2D = new Vec2(
			(maxPos.x - minPos.x) + 1,
			(maxPos.z - minPos.z) + 1
		);

		// local overworld_terrain_blend_noise          = {}
		// local __overworld_terrain_blend_noise_map_2d = core.get_value_noise_map(overworld_terrain_blend_parameters, __constant_area_2d)
		// __overworld_terrain_blend_noise_map_2d:get_2d_map_flat({ x = minp.x, y = minp.z },
		// 	overworld_terrain_blend_noise)

		final overWorldTerrainBlendNoise: LuaArray<Float> = Core.getValueNoiseMap(overWorldTerrainBlendParameters, constantArea2D).get2DMapFlat(new Vec2(minPos.x, minPos.z));

		// local overworld_terrain_noise_big          = {}
		// local __overworld_terrain_noise_map_2d_big = core.get_value_noise_map(overworld_terrain_noise_parameters_big, __constant_area_2d)
		// __overworld_terrain_noise_map_2d_big:get_2d_map_flat({ x = minp.x, y = minp.z }, overworld_terrain_noise_big)

		final overWorldTerrainNoiseBig: LuaArray<Float> = Core.getValueNoiseMap(overWorldTerrainNoiseParametersBig, constantArea2D).get2DMapFlat(new Vec2(minPos.x, minPos.z));

		// local overworld_terrain_noise_small          = {}
		// local __overworld_terrain_noise_map_2d_small = core.get_value_noise_map(overworld_terrain_noise_parameters_small,
		// 	__constant_area_2d)
		// __overworld_terrain_noise_map_2d_small:get_2d_map_flat({ x = minp.x, y = minp.z }, overworld_terrain_noise_small)

		final overWorldTerrainNoiseSmall: LuaArray<Float> = Core.getValueNoiseMap(overWorldTerrainNoiseParametersSmall, constantArea2D).get2DMapFlat(new Vec2(minPos.x, minPos.z));

		// --- @type table, table
		// local emin, emax = voxmanip:get_emerged_area()

		// local data = {}

		// voxmanip:get_data(data)

		// local area = VoxelArea:new({ MinEdge = emin, MaxEdge = emax })

		// local index = 1

		// local width = (maxp.x - minp.x) + 1
		// local depth = (maxp.z - minp.z) + 1

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
