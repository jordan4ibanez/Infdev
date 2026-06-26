package src.engine;

import src.engine.vector.EngineVector3;

@:multiReturn
extern class MinMaxPos {
	public var min: EngineVector3;
	public var max: EngineVector3;
}

@:final
abstract extern class VoxelManip {
	@:native("read_from_map")
	public function readFromMap(): MinMaxPos;
}
