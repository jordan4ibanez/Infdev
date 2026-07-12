package src.engine.vector;

import haxe.Rest;
import haxe.extern.EitherType;
import src.engine.compilercode.LuaArray;

// This is a completely virtual class.
@:native("vector2")
extern class Vector2 {
	// ? Functions
	public static inline function sort(v1: Vec2, v2: Vec2): {
		var first: Vec2;
		var second: Vec2;
	} {
		var temp: LuaArray<Vec2> = untyped __lua__("{vector.sort({0}, {1})}", v1, v2);
		return {
			first: temp[0],
			second: temp[1]
		};
	}

	public static inline function angle(v1: Vec2, v2: Vec2): Float {
		return untyped __lua__("vector.angle({0}, {1})", v1, v2);
	}

	public static inline function cross(v1: Vec2, v2: Vec2): Float {
		return untyped __lua__("vector.cross({0}, {1})", v1, v2);
	}

	public static inline function offset(v: Vec2, x: Float, y: Float, z: Float): Vec2 {
		return untyped __lua__("vector.offset({0}, {1}, {2}, {3})", v, x, y, z);
	}

	public static inline function randomInArea(min: Vec2, max: Vec2): Float {
		return untyped __lua__("vector.random_in_area({0}, {1})", min, max);
	}

	// ? Rotation-related functions
	public static inline function rotate(v: Vec2, r: Vec2): Vec2 {
		return untyped __lua__("vector.rotate({0}, {1})", v, r);
	}

	public static inline function rotateAroundAxis(v1: Vec2, v2: Vec2, a: Float): Vec2 {
		return untyped __lua__("vector.rotate_around_axis({0}, {1}, {2})", v1, v2, a);
	}

	public static inline function dirToRotation(direction: Vec2, ?up: Vec2): Vec2 {
		return untyped __lua__("vector.dir_to_rotation({0}, {1})", direction, up);
	}

	// ? Common to all vector types
	public static inline function copy(v: Vec2): Vec2 {
		return untyped __lua__("vector.copy({0})", v);
	}

	public static inline function zero(): Vec2 {
		return untyped __lua__("vector.zero()");
	}

	public static inline function randomDirection(): Vec2 {
		return untyped __lua__("vector.random_direction()");
	}

	public static inline function direction(p1: Vec2, p2: Vec2): Vec2 {
		return untyped __lua__("vector.direction({0}, {1})", p1, p2);
	}

	public static inline function distance(p1: Vec2, p2: Vec2): Float {
		return untyped __lua__("vector.distance({0}, {1})", p1, p2);
	}

	public static inline function length(v: Vec2): Float {
		return untyped __lua__("vector.length({0})", v);
	}

	public static inline function normalize(v: Vec2): Vec2 {
		return untyped __lua__("vector.normalize({0})", v);
	}

	public static inline function floor(v: Vec2): Vec2 {
		return untyped __lua__("vector.floor({0})", v);
	}

	public static inline function ceil(v: Vec2): Vec2 {
		return untyped __lua__("vector.ceil({0})", v);
	}

	public static inline function round(v: Vec2): Vec2 {
		return untyped __lua__("vector.round({0})", v);
	}

	public static inline function sign(v: Vec2, tolerance: Float): Vec2 {
		return untyped __lua__("vector.sign({0}, {1})", v, tolerance);
	}

	public static inline function abs(v: Vec2): Vec2 {
		return untyped __lua__("vector.abs({0})", v);
	}

	public static inline function apply(v: Vec2, func: (Float) -> Void, whatever: Rest<Dynamic>): Vec2 {
		return untyped __lua__("vector.apply({0}, {1}, table.unpack({2}))", v, func, whatever);
	}

	// I literally have no idea what vector.combine does.
	public static inline function equals(v1: Vec2, v2: Vec2): Bool {
		return untyped __lua__("vector.equals({0}, {1})", v1, v2);
	}

	public static inline function dot(v1: Vec2, v2: Vec2): Float {
		return untyped __lua__("vector.dot({0}, {1})", v1, v2);
	}

	public static inline function check(v: Vec2): Bool {
		return untyped __lua__("vector.check({0})", v);
	}

	public static inline function inArea(pos: Vec2, min: Vec2, max: Vec2): Bool {
		return untyped __lua__("vector.in_area({0}, {1}, {2})", pos, min, max);
	}

	// ?
	// ?
	// ? For the following functions x can be either a vector or a number:
	// ?
	// ?
	public static inline function add(v: Vec2, x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector.add({0}, {1})", v, x);
	}

	public static inline function subtract(v: Vec2, x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector.subtract({0}, {1})", v, x);
	}

	public static inline function multiply(v: Vec2, x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector.multiply({0}, {1})", v, x);
	}

	public static inline function divide(v: Vec2, x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector.divide({0}, {1})", v, x);
	}
}
// class TestIt {
// 	static function __init__() {
// 		var v1 = new AdvancedVector3(1, 1, 1);
// 		var v2 = new AdvancedVector3(100, 199, 123123);
// 		var sort = Vector.randomInArea(v1, v2);
// 		untyped print(sort);
// 		Core.requestShutdown("heck");
// 	}
// }
