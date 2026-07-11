package src.engine.vector;

import lua.Table;
import src.engine.compilercode.LuaArray;

typedef DoubleVectorReturn = {
	var first: AdvancedVector3;
	var second: AdvancedVector3;
}

// This is a completely virtual class.
abstract AdvancedVector3(Table<String, Float>) {
	public inline function new(x: Float, y: Float, z: Float) {
		this = untyped __lua__("vector.new({0}, {1}, {2})", x, y, z);
	}

	public static inline function sort(v1: AdvancedVector3, v2: AdvancedVector3): DoubleVectorReturn {
		var temp: LuaArray<AdvancedVector3> = untyped __lua__("{vector.sort({0}, {1})}", v1, v2);
		return {
			first: temp[0],
			second: temp[1]
		};
	}
}
	}
}
