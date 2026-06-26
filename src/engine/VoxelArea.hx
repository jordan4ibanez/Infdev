package src.engine;

import src.engine.vector.EngineVector3;

// ? This class is in camel case for some reason??
@:final
abstract extern class VoxelArea {
	static inline function create(minPos: EngineVector3, maxPos: EngineVector3): VoxelArea {
		return untyped __lua__("VoxelArea(minPos, maxPos)");
	}

	public function getExtent(): EngineVector3;

	public function getVolume(): Int;

	/**
	 * This is 1 indexed.
	 */
	public function index(x: Int, y: Int, z: Int): Int;

	/**
	 * This is 1 indexed.
	 */
	@:native("indexp")
	public function indexP(pos: EngineVector3): Int;

	/**
	 * This is 1 indexed.
	 */
	public function position(i: Int): EngineVector3;
}
