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
			final temp = low;
			low = high;
			high = temp;
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

		final emergedArea = voxelManip.getEmergedArea();

		final data: LuaArray<Int> = voxelManip.getData();

		final area: VoxelArea = VoxelArea.create(emergedArea.min, emergedArea.max);

		var index: Int = 1;

		final width = (maxPos.x - minPos.x) + 1;
		final depth = (maxPos.z - minPos.z) + 1;

		LuaLoop.nativeFor(i, area.iterP(minPos, maxPos), {
			final pos = area.position(i);

			if (pos.y >= 0 && pos.y <= 160) {
				// Zero indices.
				var xInData = pos.x - minPos.x;
				var zInData = pos.z - minPos.z;

				// Basically shove a 3D space into a 1D space.

				var index2D = (zInData * depth) + xInData;

				var skew = (clamp(overWorldTerrainBlendNoise[index2D], -1, 1) + 1) * 0.5;

				var bigNoiseMultiplier = 1 - skew;
				var smallNoiseMultiplier = skew;

				var rawNoise = ((overWorldTerrainNoiseBig[index2D] * bigNoiseMultiplier) + (overWorldTerrainNoiseSmall[index2D] * smallNoiseMultiplier));

				if (rawNoise == null) {
					throw "terrain generator error at index: " + Lua.tostring(index2D);
				}

				// Amplitude in nodes.

				var amplitude = 80;
				var base = 80;

				var heightAtXZ = Math.ceil(base + (amplitude * rawNoise));

				var isSandy = heightAtXZ <= oceanLevel + 3;

				if (pos.y == heightAtXZ) {
					data[i] = isSandy ? sandID : grassID;
				} else if (pos.y < heightAtXZ && pos.y >= heightAtXZ - 2) {
					data[i] = isSandy ? sandID : dirtID;
				} else if (pos.y < heightAtXZ) {
					if (!stoneDisabled) {
						var isSandstone = heightAtXZ <= oceanLevel + 3 && pos.y >= heightAtXZ - 7;
						data[i] = isSandstone ? sandstoneID : stoneID;
					}
				}
			} else if (pos.y > -1024 && pos.y < 0) {
				// Underground in the overworld.

				if (!stoneDisabled) {
					data[i] = stoneID;
				}
			}

			// This is basically superflat.
			// var pos = area.position(i);
			// if (pos.y == 80) {
			// 	data[i] = stoneID;
			// }
		});

		// voxmanip:set_data(data)
		voxelManip.setData(data);

		// core.generate_ores(voxmanip, minp, maxp)
		// todo:
		// core.generate_decorations(voxmanip, minp, maxp)
		// todo:

		// voxmanip:calc_lighting()
		voxelManip.calcLighting();
		// voxmanip:update_liquids()
		voxelManip.updateLiquids();

		// -- vm:write_to_map()
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
