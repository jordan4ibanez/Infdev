package src.engine;

import src.engine.vector.Vec3;
import lua.NativeIterator;

// ? This class is in camel case for some reason??
@:final
abstract extern class VoxelArea {
	static inline function create(minPos: Vec3, maxPos: Vec3): VoxelArea {
		return untyped __lua__("VoxelArea({0}, {1})", minPos, maxPos);
	}

	public function getExtent(): Vec3;

	public function getVolume(): Int;

	@:native("index") // 1 indexed. Don't use.
	private function indexLua(x: Float, y: Float, z: Float): Int;

	// 0 indexed.
	public inline function index(x: Float, y: Float, z: Float): Int {
		return indexLua(x, y, z) - 1;
	}

	@:native("indexp") // 1 indexed. Don't use.
	private function indexPLua(pos: Vec3): Int;

	// 0 indexed.
	public inline function indexP(pos: Vec3): Int {
		return indexP(pos) - 1;
	}

	@:native("position") // 1 indexed. Don't use.
	private function positionLua(i: Float): Vec3;

	// 0 indexed.
	public inline function position(i: Float): Vec3 {
		return positionLua(i + 1);
	}

	public function contains(x: Float, y: Float, z: Float): Bool;

	@:native("containsp")
	public function containsP(pos: Vec3): Bool;

	@:native("containsi") // 1 indexed. Don't use.
	private function containsILua(index: Float): Bool;

	// 0 indexed.
	public inline function containsI(index: Float): Bool {
		return containsILua(index + 1);
	}

	public function iter(minX: Float, minY: Float, minZ: Float, maxX: Float, maxY: Float, maxZ: Float): NativeIterator<Int>;

	@:native("iterp")
	public function iterP(minPos: Vec3, maxPos: Vec3): NativeIterator<Int>;
}
