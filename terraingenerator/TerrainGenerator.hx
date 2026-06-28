package terraingenerator;

import src.engine.compilercode.LuaLoop;
import lua.Os;
import src.engine.VoxelArea;
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

		final caveBlendNoise: LuaArray<Float> = Core.getValueNoiseMap(caveBlendParameters, constantArea3D).get3DMapFlat(minPos);

		final bigCaveNoise: LuaArray<Float> = Core.getValueNoiseMap(bigCaveNoiseParameters, constantArea3D).get3DMapFlat(minPos);

		final smallCaveNoise: LuaArray<Float> = Core.getValueNoiseMap(smallCaveNoiseParameters, constantArea3D).get3DMapFlat(minPos);

		final constantArea2D = new Vec2(
			(maxPos.x - minPos.x) + 1,
			(maxPos.z - minPos.z) + 1
		);

		final flatMapMinPos = new Vec2(minPos.x, minPos.z);

		final overWorldTerrainBlendNoise: LuaArray<Float> = Core.getValueNoiseMap(overWorldTerrainBlendParameters, constantArea2D).get2DMapFlat(flatMapMinPos);

		final overWorldTerrainNoiseBig: LuaArray<Float> = Core.getValueNoiseMap(overWorldTerrainNoiseParametersBig, constantArea2D).get2DMapFlat(flatMapMinPos);

		final overWorldTerrainNoiseSmall: LuaArray<Float> = Core.getValueNoiseMap(overWorldTerrainNoiseParametersSmall, constantArea2D).get2DMapFlat(flatMapMinPos);

		// --- @type table, table
		// local emin, emax = voxmanip:get_emerged_area()

		final emergedArea = voxelManip.getEmergedArea();

		// local data = {}
		// voxmanip:get_data(data)

		final data: LuaArray<Int> = voxelManip.getData();

		// local area = VoxelArea:new({ MinEdge = emin, MaxEdge = emax })

		final area: VoxelArea = VoxelArea.create(emergedArea.min, emergedArea.max);

		// local index = 1

		var index: Int = 1;

		// local width = (maxp.x - minp.x) + 1
		// local depth = (maxp.z - minp.z) + 1

		final width = (maxPos.x - minPos.x) + 1;
		final depth = (maxPos.z - minPos.z) + 1;

		LuaLoop.nativeFor(i, area.iterP(minPos, maxPos), {
			final pos = area.position(i);

			var heightAtXZ = 0;

			if (pos.y >= 0 && pos.y <= 160) {
				
			}
		});
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
