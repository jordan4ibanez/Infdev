package src.engine;

import src.engine.compilercode.LuaArray;
import src.engine.vector.EngineVector3;

@:final
abstract extern class ValueNoiseMap {
	@:native("get_2d_map")
	public extern function get2DMap(pos: EngineVector3): LuaArray<LuaArray<Float>>;

    
}
