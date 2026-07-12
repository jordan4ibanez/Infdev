package src.engine.vector;

import src.engine.compilercode.LuaArray;

// This is a completely virtual class.
abstract AdvancedVector3({
	var x: Float;
	var y: Float;
	var z: Float;
}) {
	public inline function new(x: Float, y: Float, z: Float) {
		this = untyped __lua__("vector.new({0}, {1}, {2})", x, y, z);
	}

	// ? Functions
	public inline function sort(v1: AdvancedVector3, v2: AdvancedVector3): {
		var first: AdvancedVector3;
		var second: AdvancedVector3;
	} {
		var temp: LuaArray<AdvancedVector3> = untyped __lua__("{vector.sort({0}, {1})}", v1, v2);
		return {
			first: temp[0],
			second: temp[1]
		};
	}

	public inline function angle(v1: AdvancedVector3, v2: AdvancedVector3): Float {
		return untyped __lua__("vector.angle({0}, {1})", v1, v2);
	}

	public inline function cross(v1: AdvancedVector3, v2: AdvancedVector3): Float {
		return untyped __lua__("vector.cross({0}, {1})", v1, v2);
	}

	public inline function offset(v: AdvancedVector3, x: Float, y: Float, z: Float): AdvancedVector3 {
		return untyped __lua__("vector.offset({0}, {1}, {2}, {3})", v1, x, y, z);
	}

	// ? Operators (just kinda works)
	//
	//
	//
	// ? Rotation-related functions
	public inline function rotate(v: AdvancedVector3, r: AdvancedVector3): AdvancedVector3 {
		return untyped __lua__("vector.rotate({0}, {1})", min, max);
	}

	public inline function rotateAroundAxis(v: AdvancedVector3, r: AdvancedVector3, a: Float): AdvancedVector3 {
		return untyped __lua__("vector.rotate_around_axis({0}, {1}, {2})", min, max, a);
	}
}
