package src.engine.vector;

import src.engine.compilercode.LuaArray;

// This is a completely virtual class.

@:forward
abstract Vec3({
	public var x: Float;
	public var y: Float;
	public var z: Float;
}) {
	public inline function new(?x: Float, ?y: Float, ?z: Float) {
		var x = x ?? 0;
		var y = y ?? 0;
		var z = z ?? 0;
		this = untyped __lua__("vector.new({0}, {1}, {2})", x, y, z);
	}

	public inline function set(otherVec: Vec3): Vec3 {
		this.x = otherVec.x;
		this.y = otherVec.y;
		this.z = otherVec.z;
		return cast this;
	}

	public inline function multiplyScalar(scalar: Float): Vec3 {
		this.x *= scalar;
		this.y *= scalar;
		this.z *= scalar;
		return cast this;
	}

	// !
	// !
	// ! Only engine functions below this point.
	// !
	// !
	// ? Functions
	public inline function sort(v2: Vec3): {
		var first: Vec3;
		var second: Vec3;
	} {
		var temp: LuaArray<Vec3> = untyped __lua__("{vector.sort({0}, {1})}", this, v2);
		return {
			first: temp[0],
			second: temp[1]
		};
	}

	public inline function angle(v2: Vec3): Float {
		return untyped __lua__("vector.angle({0}, {1})", this, v2);
	}

	public inline function cross(v2: Vec3): Float {
		return untyped __lua__("vector.cross({0}, {1})", this, v2);
	}

	public inline function offset(x: Float, y: Float, z: Float): Vec3 {
		return untyped __lua__("vector.offset({0}, {1}, {2}, {3})", this, x, y, z);
	}

	// ? Operators (just kinda work)
	//
	//
	//
	// ? Rotation-related functions
	public inline function rotate(r: Vec3): Vec3 {
		return untyped __lua__("vector.rotate({0}, {1})", this, r);
	}

	public inline function rotateAroundAxis(v2: Vec3, a: Float): Vec3 {
		return untyped __lua__("vector.rotate_around_axis({0}, {1}, {2})", this, v2, a);
	}

	// ? Common to all vector types
	public static inline function zero(): Vec3 {
		return untyped __lua__("vector.zero()");
	}
}

class TestIt {
	static function __init__() {
		var v1 = new Vec3(1, 1, 1);
		var v2 = new Vec3(100, 199, 123123);

		var sort = v1.angle(v2) + 1;

		untyped print(sort);

		Core.requestShutdown("heck");
	}
}
