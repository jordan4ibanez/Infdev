package src.game.decoration;

import src.engine.NoiseParams;
import src.engine.compilercode.LuaArray;
import src.engine.definition.Decoration;

class SugarcaneStalk implements DecorationSimple {
	public var param2: Int;
	public var place_on: LuaArray<String>;
	public var sidelen: Int;
	public var fill_ratio: Float;
	public var noise_params: NoiseParams;
	public var biomes: LuaArray<String>;
	public var y_min: Int;
	public var y_max: Int;
	public var spawn_by: LuaArray<String>;
	public var check_offset: Int;
	public var num_spawn_by: Int;
	public var flags: Array<DecorationFlags>;
	public var decoration: String;
	public var height: Int;
	public var height_max: Int;
	public var param2_max: Int;
	public var place_offset_y: Int;
}
