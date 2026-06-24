package src.engine;

import luantitypes.Core;

final class TerrainGeneratorLoader {
	static function __init__() {
		final modPath: Null<String> = Core.getModPath(Core.getCurrentModName());

		if (modPath == null) {
			throw "Current mod path was null. Cannot load terrain generator.";
		}

		Core.registerMapgenScript(modPath + "/terrain_generator.lua");

		
	}
}
