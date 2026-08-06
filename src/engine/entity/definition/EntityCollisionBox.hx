package src.engine.entity.definition;

import lua.Table;

@:forward
abstract EntityCollisionBox(Table<Int, Float>) from Table<Int, Float> to Table<Int, Float> {
	public inline function new(x1: Float, y1: Float, z1: Float, x2: Float, y2: Float, z2: Float) {
		this = Table.create([x1, y1, z1, x2, y2, z2]);
	}

	@:arrayAccess
	inline function get(index: Int): Float {
		return untyped this[index + 1];
	}
}
