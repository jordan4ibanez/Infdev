package src.game.decoration;

import src.engine.NoiseParams;
import src.engine.compilercode.LuaArray;
import src.engine.definition.Decoration;
import src.engine.vector.Vec3;

final class SugarcaneStalk implements DecorationSimple {
	public var place_on: LuaArray<String> = ["infdev:sand"];
	public var sidelen: Int = 16;
	public var fill_ratio: Float = 1.0;
	public var noise_params: NoiseParams = {
		offset: 0.035,
		scale: 0.023,
		spread: new Vec3(35, 35, 35),
		octaves: 2,
		persistence: 0.2,
		lacunarity: 6.0,
	};
	public var biomes: LuaArray<String>;
	public var y_min: Int;
	public var y_max: Int;
	public var spawn_by: LuaArray<String> = ["infdev:water_source"];
	public var check_offset: Int;
	public var num_spawn_by: Int = 1;
	public var flags: LuaArray<DecorationFlags>;
	public var decoration: String = "infdev:sugarcane";
	public var height: Int = 2;
	public var height_max: Int = 4;
	public var param2: Int;
	public var param2_max: Int;
	public var place_offset_y: Int;
}
