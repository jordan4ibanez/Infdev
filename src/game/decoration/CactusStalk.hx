package src.game.decoration;

import src.engine.NoiseParams;
import src.engine.compilercode.LuaArray;
import src.engine.definition.Decoration.DecorationFlags;
import src.engine.definition.Decoration.DecorationSimple;
import src.engine.vector.Vec3;

final class CactusStalk implements DecorationSimple {
	public var place_on: LuaArray<String> = ["infdev:sand"];
	public var sidelen: Int = 16;
	public var fill_ratio: Float;
	public var noise_params: NoiseParams = {
		offset: -0.001,
		scale: 0.022,
		spread: new Vec3(36, 36, 36),
		octaves: 3,
		persistence: 0.4,
		lacunarity: 5.0,
	};
	public var biomes: LuaArray<String>;
	public var y_min: Int;
	public var y_max: Int;
	public var spawn_by: LuaArray<String>;
	public var check_offset: Int;
	public var num_spawn_by: Int;
	public var flags: LuaArray<DecorationFlags>;
	public var decoration: String = "infdev:cactus";
	public var height: Int = 1;
	public var height_max: Int = 3;
	public var param2: Int;
	public var param2_max: Int;
	public var place_offset_y: Int;
}
