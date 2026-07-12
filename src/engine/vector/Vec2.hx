package src.engine.vector;

import haxe.Rest;
import haxe.extern.EitherType;
import src.engine.compilercode.LuaArray;

// todo: check all this. This was copied from Vec3 and just slightly changed.
// This is a completely virtual class.
@:forward
abstract Vec2({
	public var x: Float;
	public var y: Float;
}) {
	public inline function new(?x: Float, ?y: Float) {
		var x = x ?? 0;
		var y = y ?? 0;

		this = untyped __lua__("vector.new({0}, {1})", x, y);
	}

	public inline function set(otherVec: Vec2): Vec2 {
		this.x = otherVec.x;
		this.y = otherVec.y;

		return cast this;
	}

	public inline function multiplyScalar(scalar: Float): Vec2 {
		this.x *= scalar;
		this.y *= scalar;

		return cast this;
	}

	// !
	// !
	// ! Only engine functions below this point.
	// !
	// !
	// ? Functions
	public inline function sort(v2: Vec2): {first: Vec2, second: Vec2} {
		var temp: LuaArray<Vec2> = untyped __lua__("{vector.sort({0}, {1})}", this, v2);
		return {
			first: temp[0],
			second: temp[1]
		};
	}

	public inline function angle(v2: Vec2): Float {
		return untyped __lua__("vector.angle({0}, {1})", this, v2);
	}

	public inline function cross(v2: Vec2): Float {
		return untyped __lua__("vector.cross({0}, {1})", this, v2);
	}

	public inline function offset(x: Float, y: Float, z: Float): Vec2 {
		return untyped __lua__("vector.offset({0}, {1}, {2}, {3})", this, x, y, z);
	}

	// ? Operators (just kinda work)
	//
	//
	//
	// ? Rotation-related functions
	public inline function rotate(r: Vec2): Vec2 {
		return untyped __lua__("vector.rotate({0}, {1})", this, r);
	}

	public inline function rotateAroundAxis(v2: Vec2, a: Float): Vec2 {
		return untyped __lua__("vector.rotate_around_axis({0}, {1}, {2})", this, v2, a);
	}

	// ? Common to all vector types
	public inline function copy(): Vec2 {
		return untyped __lua__("vector.copy({0})", this);
	}

	public inline function direction(p2: Vec2): Vec2 {
		return untyped __lua__("vector.direction({0}, {1})", this, p2);
	}

	public inline function distance(p2: Vec2): Float {
		return untyped __lua__("vector.distance({0}, {1})", this, p2);
	}

	public inline function length(): Float {
		return untyped __lua__("vector.length({0})", this);
	}

	public inline function normalize(): Vec2 {
		return untyped __lua__("vector.normalize({0})", this);
	}

	public inline function floor(): Vec2 {
		return untyped __lua__("vector.floor({0})", this);
	}

	public inline function ceil(): Vec2 {
		return untyped __lua__("vector.ceil({0})", this);
	}

	public inline function round(): Vec2 {
		return untyped __lua__("vector.round({0})", this);
	}

	public inline function sign(tolerance: Float): Vec2 {
		return untyped __lua__("vector.sign({0}, {1})", this, tolerance);
	}

	public inline function abs(): Vec2 {
		return untyped __lua__("vector.abs({0})", this);
	}

	public inline function apply(func: (Float) -> Void, whatever: Rest<Dynamic>): Vec2 {
		return untyped __lua__("vector.apply({0}, {1}, table.unpack({2}))", this, func, whatever);
	}

	// I literally have no idea what vector.combine does.
	public inline function equals(v2: Vec2): Bool {
		return untyped __lua__("vector.equals({0}, {1})", this, v2);
	}

	public inline function dot(v2: Vec2): Float {
		return untyped __lua__("vector.dot({0}, {1})", this, v2);
	}

	public inline function check(): Bool {
		return untyped __lua__("vector.check({0})", this);
	}

	public inline function inArea(min: Vec2, max: Vec2): Bool {
		return untyped __lua__("vector.in_area({0}, {1}, {2})", this, min, max);
	}

	// ?
	// ?
	// ? For the following functions x can be either a vector or a number:
	// ?
	// ?
	public inline function add(x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector.add({0}, {1})", this, x);
	}

	public inline function subtract(x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector.subtract({0}, {1})", this, x);
	}

	public inline function multiply(x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector.multiply({0}, {1})", this, x);
	}

	public inline function divide(x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector.divide({0}, {1})", this, x);
	}
}
// class TestIt {
// 	static function __init__() {
// 		var v1 = new Vec2(1, 1, 1);
// 		var v2 = new Vec2(100, 199, 123123);
// 		var sort = v1.angle(v2) + 1;
// 		untyped print(sort);
// 		Core.requestShutdown("heck");
// 	}
// }
