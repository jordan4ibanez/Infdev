package src.engine;

import lua.Lua;
import src.engine.Core;

final class TerrainGeneratorLoader {
	static var instance = new TerrainGeneratorLoader();

	public function new() {
		fixCxxTerrainGenerator();

		final modPath: Null<String> = Core.getModPath(Core.getCurrentModName());

		if (modPath == null) {
			throw "Current mod path was null. Cannot load terrain generator.";
		}

		Core.registerMapgenScript(modPath + "/terrain_generator.lua");

		Lua.print("[Terrain generator loaded]");
	}

	function fixCxxTerrainGenerator() {
		// Gotta set the mapgen setting manually or else this thing will try to load v7 with the makefile.

		Core.setMapgenSetting("mg_name", "singlenode", true);
		Core.setMapgenSetting("mg_flags", "nolight", true);
	}
}
