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
		// Gotta set the mapgen setting manually or else this thing will try to load v7 with the makefile.

		Core.setMapgenSetting("mg_name", "singlenode", true);
		Core.setMapgenSetting("mg_flags", "nolight", true);
	}
}
