package src.engine;

import src.engine.compilercode.LuaArray;
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

	/**
	 * To be used only by a VoxelManip object from core.get_mapgen_object.
	 */
	@:native("set_lighting")
	public function setLighting(light: LuaArray<LightData>, ?p1: EngineVector3, ?p2: EngineVector3): Void;

	@:native("get_light_data")
	public function getLightData(?buffer: LuaArray<LightData>): LuaArray<LightData>;

	@:native("set_light_data")
	public function setLightData(lightData: LuaArray<LightData>): Void;

	@:native("get_param2_data")
	public function getParam2Data(?buffer: LuaArray<Int>): LuaArray<Int>;

	@:native("set_param2_data")
	public function setParam2Data(param2Data: LuaArray<Int>): Void;

	/**
	 * To be used only with a VoxelManip object from core.get_mapgen_object.
	 */
	@:native("calc_lighting")
	public function calcLighting(?p1: EngineVector3, ?p2: EngineVector3, ?propagateShadow: Bool): Void;

	@:native("update_liquids")
	public function updateLiquids(): Void;

	@:native("get_emerged_area")
	public function getEmergedArea(): MinMaxPos;

	/**
	 * Since Lua's garbage collector is not aware of the potentially significant 
	 * memory behind a VoxelManip, frequent VoxelManip usage can cause the server
	 * to run out of RAM. Therefore it's recommend to call this method once you're
	 * done with the VoxelManip.
	 * 
	 * ! Do not call this in the external terrain generator threads.
	 */
	@:native("close")
	public function close(): Void;
}
