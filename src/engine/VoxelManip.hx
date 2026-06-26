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
	public function readFromMap(p1: EngineVector3, p2: EngineVector3): MinMaxPos;

	@:native("initialize")
	public function initialize(p1: EngineVector3, p2: EngineVector3, ?node: Int): MinMaxPos;
    
}
