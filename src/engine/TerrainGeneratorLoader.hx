package src.engine;

import src.engine.Core;

final class TerrainGeneratorLoader {
	static function __init__() {
		fixCxxTerrainGenerator();

		

		final modPath: Null<String> = Core.getModPath(Core.getCurrentModName());

		if (modPath == null) {
			throw "Current mod path was null. Cannot load terrain generator.";
		}

		Core.registerMapgenScript(modPath + "/terrain_generator.lua");
	}

	static function fixCxxTerrainGenerator() {
		Core.registerAlias("mapgen_stone", "infdev:stone");
		Core.registerAlias("mapgen_water_source", "infdev:water_source");
	}
}
