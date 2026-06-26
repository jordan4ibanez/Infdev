package src.engine;

import src.engine.compilercode.LuaArray;
import lua.Table;
import src.engine.vector.EngineVector3;

@:multiReturn
extern class MinMaxPos {
	public var min: EngineVector3;
	public var max: EngineVector3;
}

typedef LightData = {
	var day: Int;
	var night: Int;
}

@:final
abstract extern class VoxelManip {
	@:native("read_from_map")
	public function readFromMap(p1: EngineVector3, p2: EngineVector3): MinMaxPos;

	@:native("initialize")
	public function initialize(p1: EngineVector3, p2: EngineVector3, ?node: Int): MinMaxPos;

	@:native("write_to_map")
	public function writeToMap(?light: Bool): Void;

	@:native("get_node_at")
	public function getNodeAt(pos: EngineVector3): NodeTable;

	@:native("set_node_at")
	public function setNodeAt(pos: EngineVector3, node: NodeTable): Void;

	@:native("get_data")
	public function getData(?buffer: LuaArray<Int>): LuaArray<Int>;

	@:native("set_data")
	public function setData(data: LuaArray<Int>): Void;

	@:native("set_lighting")
	public function setLighting(light: LuaArray<LightData>, ?p1: EngineVector3, ?p2: EngineVector3): Void;
}
