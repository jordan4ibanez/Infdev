package src.engine.vector;

import src.engine.compilercode.LuaArray;

// This is a completely virtual class.
abstract AdvancedVector3({
	public var x: Float;
	public var y: Float;
	public var z: Float;
}) {
	public inline function new(x: Float, y: Float, z: Float) {
		this = untyped __lua__("vector.new({0}, {1}, {2})", x, y, z);
	}

	public inline function set(engineVec3: EngineVector3): AdvancedVector3 {
		this.x = engineVec3.x;
		this.y = engineVec3.y;
		this.z = engineVec3.z;
		return cast this;
	}

	public inline function multiplyScalar(scalar: Float): AdvancedVector3 {
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
	public inline function sort(v2: AdvancedVector3): {
		var first: AdvancedVector3;
		var second: AdvancedVector3;
	} {
		var temp: LuaArray<AdvancedVector3> = untyped __lua__("{vector.sort({0}, {1})}", this, v2);
		return {
			first: temp[0],
			second: temp[1]
		};
	}

	public inline function angle(v2: AdvancedVector3): Float {
		return untyped __lua__("vector.angle({0}, {1})", this, v2);
	}

	public inline function cross(v2: AdvancedVector3): Float {
		return untyped __lua__("vector.cross({0}, {1})", this, v2);
	}

	public inline function offset(x: Float, y: Float, z: Float): AdvancedVector3 {
		return untyped __lua__("vector.offset({0}, {1}, {2}, {3})", this, x, y, z);
	}

	// ? Operators (just kinda work)
	//
	//
	//
	// ? Rotation-related functions
	public inline function rotate(r: AdvancedVector3): AdvancedVector3 {
		return untyped __lua__("vector.rotate({0}, {1})", this, r);
	}

	public inline function rotateAroundAxis(v2: AdvancedVector3, a: Float): AdvancedVector3 {
		return untyped __lua__("vector.rotate_around_axis({0}, {1}, {2})", this, v2, a);
	}
}

class TestIt {
	static function __init__() {
		var v1 = new AdvancedVector3(1, 1, 1);
		var v2 = new AdvancedVector3(100, 199, 123123);

		var sort = v1.angle(v2) + 1;

		untyped print(sort);

		Core.requestShutdown("heck");
	}
}
