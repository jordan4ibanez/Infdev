package src.engine;

import src.engine.compilercode.LuaArray;
import src.engine.vector.EngineVector2;

@:final
abstract extern class ValueNoiseMap {
	@:native("get_2d_map")
	public function get2DMap(pos: EngineVector3): LuaArray<LuaArray<Float>>;

	@:native("get_3d_map")
	public function get3DMap(pos: EngineVector3): LuaArray<LuaArray<LuaArray<Float>>>;

	@:native("get_2d_map_flat")
	public function get2DMapFlat(pos: EngineVector2, ?buffer: LuaArray<Float>): LuaArray<Float>;

	@:native("get_3d_map_flat")
	public function get3DMapFlat(pos: EngineVector3, ?buffer: LuaArray<Float>): LuaArray<Float>;

	@:native("calc_2d_map")
	public function calc2DMap(pos: EngineVector2): Void;

	@:native("calc_3d_map")
	public function calc3DMap(pos: EngineVector3): Void;

	@:native("get_map_slice")
	public function getMapSlice(sliceOffset: EngineVector3, sliceSize: EngineVector3, buffer: LuaArray<Float>): Void;
}
