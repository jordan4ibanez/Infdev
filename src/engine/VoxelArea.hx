package src.engine;

import src.engine.vector.EngineVector3;
import lua.NativeIterator;

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

	public function contains(x: Int, y: Int, z: Int): Bool;

	@:native("containsp")
	public function containsP(pos: EngineVector3): Bool;

	@:native("containsi")
	public function containsI(index: Int): Bool;

	public function iter(minX: Int, minY: Int, minZ: Int, maxX: Int, maxY: Int, maxZ: Int): NativeIterator<Int>;

	@:native("iterp")
	public function iterP(minPos: EngineVector3, maxPos: EngineVector3): NativeIterator<Int>;
}
