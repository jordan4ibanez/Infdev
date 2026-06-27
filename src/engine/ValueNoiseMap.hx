package src.engine;

import src.engine.compilercode.LuaArray;
import src.engine.vector.EngineVector3;

@:final
abstract extern class ValueNoiseMap {
	@:native("get_2d_map")
	public extern function get2DMap(pos: EngineVector3): LuaArray<LuaArray<Float>>;

	@:native("get_3d_map")
	public extern function get3DMap(pos: EngineVector3): LuaArray<LuaArray<LuaArray<Float>>>;

	@:native("get_2d_map_flat")
	public extern function get2DMapFlat(pos: EngineVector3): LuaArray<Float>;

	@:native("get_3d_map_flat")
	public extern function get3DMapFlat(pos: EngineVector3): LuaArray<Float>;

	@:native("calc_2d_map")
	public extern function calc2DMap(pos: EngineVector3): Void;

	@:native("calc_3d_map")
	public extern function calc3DMap(pos: EngineVector3): Void;
}
