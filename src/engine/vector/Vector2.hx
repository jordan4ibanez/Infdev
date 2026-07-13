package src.engine.vector;

import haxe.Rest;
import haxe.extern.EitherType;
import src.engine.compilercode.LuaArray;

// todo: check all this. This was copied from Vector3 and just slightly changed.
// This is a completely virtual class.
@:native("vector2")
extern class Vector2 {
	// ? Functions
	public static inline function fromAngle(angle: Float): Vec2 {
		return untyped __lua__("vector2.from_angle({0})", angle);
	}

	public static inline function toAngle(v: Vec2): Float {
		return untyped __lua__("vector2.to_angle({0})", v);
	}

	public static inline function sort(v1: Vec2, v2: Vec2): {first: Vec2, second: Vec2} {
		var temp: LuaArray<Vec2> = untyped __lua__("{vector2.sort({0}, {1})}", v1, v2);
		return {
			first: temp[0],
			second: temp[1]
		};
	}

	public static inline function angle(v1: Vec2, v2: Vec2): Float {
		return untyped __lua__("vector2.angle({0}, {1})", v1, v2);
	}

	public static inline function offset(v: Vec2, x: Float, y: Float): Vec2 {
		return untyped __lua__("vector2.offset({0}, {1}, {2})", v, x, y);
	}

	public static inline function randomInArea(min: Vec2, max: Vec2): Vec2 {
		return untyped __lua__("vector2.random_in_area({0}, {1})", min, max);
	}

	// ? Rotation-related functions
	public static inline function rotate(v: Vec2, r: Float): Vec2 {
		return untyped __lua__("vector2.rotate({0}, {1})", v, r);
	}

	// ? Common to all vector types
	public static inline function copy(v: Vec2): Vec2 {
		return untyped __lua__("vector2.copy({0})", v);
	}

	public static inline function zero(): Vec2 {
		return untyped __lua__("vector2.zero()");
	}

	public static inline function randomDirection(): Vec2 {
		return untyped __lua__("vector2.random_direction()");
	}

	public static inline function direction(p1: Vec2, p2: Vec2): Vec2 {
		return untyped __lua__("vector2.direction({0}, {1})", p1, p2);
	}

	public static inline function distance(p1: Vec2, p2: Vec2): Float {
		return untyped __lua__("vector2.distance({0}, {1})", p1, p2);
	}

	public static inline function length(v: Vec2): Float {
		return untyped __lua__("vector2.length({0})", v);
	}

	public static inline function normalize(v: Vec2): Vec2 {
		return untyped __lua__("vector2.normalize({0})", v);
	}

	public static inline function floor(v: Vec2): Vec2 {
		return untyped __lua__("vector2.floor({0})", v);
	}

	public static inline function ceil(v: Vec2): Vec2 {
		return untyped __lua__("vector2.ceil({0})", v);
	}

	public static inline function round(v: Vec2): Vec2 {
		return untyped __lua__("vector2.round({0})", v);
	}

	public static inline function sign(v: Vec2, tolerance: Float): Vec2 {
		return untyped __lua__("vector2.sign({0}, {1})", v, tolerance);
	}

	public static inline function abs(v: Vec2): Vec2 {
		return untyped __lua__("vector2.abs({0})", v);
	}

	public static inline function apply(v: Vec2, func: (Float) -> Float, whatever: Rest<Dynamic>): Vec2 {
		return untyped __lua__("vector2.apply({0}, {1}, table.unpack({2}))", v, func, whatever);
	}

	// I literally have no idea what vector2.combine does.
	public static inline function equals(v1: Vec2, v2: Vec2): Bool {
		return untyped __lua__("vector2.equals({0}, {1})", v1, v2);
	}

	public static inline function dot(v1: Vec2, v2: Vec2): Float {
		return untyped __lua__("vector2.dot({0}, {1})", v1, v2);
	}

	public static inline function check(v: Vec2): Bool {
		return untyped __lua__("vector2.check({0})", v);
	}

	public static inline function inArea(pos: Vec2, min: Vec2, max: Vec2): Bool {
		return untyped __lua__("vector2.in_area({0}, {1}, {2})", pos, min, max);
	}

	// ?
	// ?
	// ? For the following functions x can be either a vector or a number:
	// ?
	// ?
	public static inline function add(v: Vec2, x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector2.add({0}, {1})", v, x);
	}

	public static inline function subtract(v: Vec2, x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector2.subtract({0}, {1})", v, x);
	}

	public static inline function multiply(v: Vec2, x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector2.multiply({0}, {1})", v, x);
	}

	public static inline function divide(v: Vec2, x: EitherType<Vec2, Float>): Vec2 {
		return untyped __lua__("vector2.divide({0}, {1})", v, x);
	}
}
// class TestIt {
// 	static function __init__() {
// 		var v1 = new AdvancedVector3(1, 1, 1);
// 		var v2 = new AdvancedVector3(100, 199, 123123);
// 		var sort = vector2.randomInArea(v1, v2);
// 		untyped print(sort);
// 		Core.requestShutdown("heck");
// 	}
// }
